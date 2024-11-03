import ArgumentParser
import Foundation
import SwiftyScripty

//sourcery: AutoMockable
public protocol SetupScript {
    func setup(at path: URL, print: PrintType) async throws
    func build(
        at path: URL,
        with configuration: SetupScriptModels.Scripts?,
        print: PrintType
    ) async throws
}

extension SetupScript {
    func setup(at path: URL) async throws {
        try await setup(at: path, print: .standard)
    }

    func build(at path: URL, print: PrintType = .standard) async throws {
        try await build(at: path, with: nil, print: print)
    }
}

struct SetupScriptImpl: SetupScript {
    // MARK: - Constants

    enum Constants {
        static let injectionKeysFolderName = "InjectionKeys"
        static let mocksFolderName = "Mocks"
        static let testKeysFolderName = "TestKeys"
        static let nameArgument = "scriptName"
    }

    // MARK: - Injected Values
    
    @Injected(\.shell) var shell: Shell
    @Injected(\.fileUtility) var fileUtility: FileUtility
    @Injected(\.sourceryWrapper) var sourcery: SourceryWrapper

    // MARK: - Resources

    let injectionKeysTemplatePath = Bundle.module.url(
        forResource: "InjectionKeys",
        withExtension: "stencil",
        subdirectory: "Resources/Templates/Sourcery"
    )

    let mocksTemplatePath = Bundle.module.url(
        forResource: "AutoMockable",
        withExtension: "stencil",
        subdirectory: "Resources/Templates/Sourcery"
    )

    let mockKeysTemplatePath = Bundle.module.url(
        forResource: "TestKeys",
        withExtension: "stencil",
        subdirectory: "Resources/Templates/Sourcery"
    )

    func setup(at path: URL, print: PrintType = .standard) async throws {
        // Read Configuration

        shell.print(color: .yellow, text: "Reading Configuration file...")
        let configuration = try readScriptConfiguration(at: path)
        if print == .interactive { shell.clear(numberOfLines: 1) }
        shell.print(color: .green, text: "✅ Configuration file read")

        for scriptConfiguration in configuration.scripts {
            // Get Paths
            let paths = getPathConfiguration(at: path, for: scriptConfiguration)

            // Remove Generated Code
            removeGeneratedCode(at: paths, for: scriptConfiguration)

            // Generate Injection Keys
            try await generateInjectionKeys(at: paths, for: scriptConfiguration, print: print)

            // Generate Mocks
            try await generateMocks(at: paths, for: scriptConfiguration, print: print)

            // Generate Mock Keys
            try await generateMockKeys(at: paths, for: scriptConfiguration, print: print)
        }
    }

    func build(
        at path: URL,
        with configuration: SetupScriptModels.Scripts?,
        print: PrintType
    ) async throws {
        let config = try configuration ?? readScriptConfiguration(at: path)

        var hasError = false
        for scriptConfiguration in config.scripts {
            if scriptConfiguration.skipBuild { continue }

            // Delete previous script
            if fileUtility.fileExists(at: path.appending(path: scriptConfiguration.scriptName)) {
                fileUtility.deleteFile(at: path.appending(path: scriptConfiguration.scriptName))
            }

            // Run command to build script
            let command = [
                "cd \(path.getFullPath())",
                "swift build --configuration release",
                "cp -f .build/release/\(scriptConfiguration.scriptName) ./\(scriptConfiguration.scriptName)"
            ].joined(separator: ";")
            shell.print(color: .yellow, text: "Building \(scriptConfiguration.scriptName)...")
            let commandOutput = await shell.run(command: command, shellType: .zsh)

            // Print outcome
            switch print {
            case .verbose: handleVerbose(command: commandOutput)
            case .interactive: shell.clear(numberOfLines: 1)
            case .standard: break
            }

            if commandOutput.succeeded {
                shell.print(color: .green, text: "✅ Script Built")
            } else {
                hasError = true
                shell.print(color: .red, text: SetupScriptModels.Errors.buildingScript.localizedDescription)
            }
        }

        if hasError { throw SetupScriptModels.Errors.buildingScript }
    }
}

// MARK: - Helper Functions

private extension SetupScriptImpl {
    func handleVerbose(command: Command?) {
        guard let command else { return }

        shell.print(color: .clear, text: command.output)
        if !command.succeeded {
            shell.print(color: .red, text: command.errorOutput)
        }
    }

    func readScriptConfiguration(
        at path: URL
    ) throws -> SetupScriptModels.Scripts {
        let configurationPath = path.appending(path: ".swiftyScriptyConfig.json")
        guard
            fileUtility.fileExists(at: configurationPath),
            let config = fileUtility.readFile(at: configurationPath),
            let data = config.data(using: .utf8)
        else {
            throw SetupScriptModels.Errors.notAScript
        }

        do {
            return try JSONDecoder().decode(SetupScriptModels.Scripts.self, from: data)
        } catch {
            throw SetupScriptModels.Errors.wrongConfigurationFile
        }
    }

    func getPathConfiguration(
        at root: URL,
        for configuration: SetupScriptModels.ScriptConfiguration
    ) -> SetupScriptModels.PathConfiguration {
        let injectionKeysPath = root
            .appending(path: configuration.injectionKeysPath)
            .appending(component: Constants.injectionKeysFolderName)
        let mocksPath = root
            .appending(path: configuration.mocksPath)
            .appending(component: Constants.mocksFolderName)
        let testKeysPath = root
            .appending(path: configuration.mockKeysPath)
            .appending(component: Constants.testKeysFolderName)
        return SetupScriptModels.PathConfiguration(
            root: root,
            sources: root.appending(path: configuration.sources),
            injectionKeys: injectionKeysPath,
            mocks: mocksPath,
            testKeys: testKeysPath
        )
    }

    func removeGeneratedCode(
        at paths: SetupScriptModels.PathConfiguration,
        for configuration: SetupScriptModels.ScriptConfiguration
    ) {
        _ = fileUtility.deleteFile(at: paths.injectionKeys)
        _ = fileUtility.deleteFile(at: paths.mocks)
        _ = fileUtility.deleteFile(at: paths.testKeys)
    }

    func generateInjectionKeys(
        at paths: SetupScriptModels.PathConfiguration,
        for configuration: SetupScriptModels.ScriptConfiguration,
        print: PrintType = .standard
    ) async throws {
        shell.print(color: .yellow, text: "Generating Injection Keys...")
        guard let injectionKeysTemplatePath else { throw SetupScriptModels.Errors.generatingInjectionKeys }

        let keysCommand = await sourcery.generateCode(
            templatePaths: [injectionKeysTemplatePath],
            sourcePaths: [paths.sources],
            outputPath: paths.injectionKeys,
            args: [SourceryWrapperArguments(key: Constants.nameArgument, value: configuration.scriptName)],
            trimSourceryHeader: false
        )

        switch print {
        case .verbose: handleVerbose(command: keysCommand)
        case .interactive: shell.clear(numberOfLines: 1)
        case .standard: break
        }

        guard keysCommand.succeeded else { throw SetupScriptModels.Errors.generatingInjectionKeys }
        shell.print(color: .green, text: "✅ Generated Injection Keys")
    }

    func generateMocks(
        at paths: SetupScriptModels.PathConfiguration,
        for configuration: SetupScriptModels.ScriptConfiguration,
        print: PrintType = .standard
    ) async throws {
        shell.print(color: .yellow, text: "Generating Mock Files...")
        guard let mocksTemplatePath else { throw SetupScriptModels.Errors.generatingMocks }
        let mocksCommand = await sourcery.generateCode(
            templatePaths: [mocksTemplatePath],
            sourcePaths: [paths.sources],
            outputPath: paths.mocks,
            args: [SourceryWrapperArguments(key: Constants.nameArgument, value: configuration.scriptName)],
            trimSourceryHeader: false
        )

        switch print {
        case .verbose: handleVerbose(command: mocksCommand)
        case .interactive: shell.clear(numberOfLines: 1)
        case .standard: break
        }

        guard mocksCommand.succeeded else { throw SetupScriptModels.Errors.generatingMocks }
        shell.print(color: .green, text: "✅ Generated Mocks")
    }

    func generateMockKeys(
        at paths: SetupScriptModels.PathConfiguration,
        for configuration: SetupScriptModels.ScriptConfiguration,
        print: PrintType = .standard
    ) async throws {
        shell.print(color: .yellow, text: "Generating Mock Keys...")
        guard let mockKeysTemplatePath else { throw SetupScriptModels.Errors.generatingMockKeys }

        let mockKeysCommand = await sourcery.generateCode(
            templatePaths: [mockKeysTemplatePath],
            sourcePaths: [paths.sources],
            outputPath: paths.testKeys,
            args: [SourceryWrapperArguments(key: Constants.nameArgument, value: configuration.scriptName)],
            trimSourceryHeader: false
        )

        switch print {
        case .verbose: handleVerbose(command: mockKeysCommand)
        case .interactive: shell.clear(numberOfLines: 1)
        case .standard: break
        }

        guard mockKeysCommand.succeeded else { throw SetupScriptModels.Errors.generatingMocks }
        shell.print(color: .green, text: "✅ Generated Mock Keys")
    }
}



