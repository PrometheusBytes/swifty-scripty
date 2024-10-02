import ArgumentParser
import Foundation
import SwiftyScripty
import Yams

//sourcery: AutoMockable
public protocol SetupScript {
    func setup(at path: URL, print: PrintType) async throws
    func build(
        at path: URL,
        with configuration: ScriptConfiguration?,
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

    let injectionKeysPath = Bundle.module.url(
        forResource: "InjectionKeys",
        withExtension: "stencil",
        subdirectory: "Resources/Templates/Sourcery"
    )

    let mocksPath = Bundle.module.url(
        forResource: "AutoMockable",
        withExtension: "stencil",
        subdirectory: "Resources/Templates/Sourcery"
    )

    let mockKeysPath = Bundle.module.url(
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

        // Remove Generated Code

        let injectionKeysPath = path
            .appending(path: configuration.injectionKeysPath)
            .appending(component: Constants.injectionKeysFolderName)
        _ = fileUtility.deleteFile(at: injectionKeysPath)
        let mocksPath = path
            .appending(path: configuration.mocksPath)
            .appending(component: Constants.mocksFolderName)
        _ = fileUtility.deleteFile(at: mocksPath)
        let testKeysPath = path
            .appending(path: configuration.mockKeysPath)
            .appending(component: Constants.testKeysFolderName)
        _ = fileUtility.deleteFile(at: testKeysPath)

        // Generate Injection Keys

        shell.print(color: .yellow, text: "Generating Injection Keys...")
        let sourcesPath = path.appending(path: configuration.sources)
        guard let injectionKeysCommand = generateInjectionKeysConfigurationFile(
            sourcesPath: sourcesPath,
            generatedFilesPath: injectionKeysPath,
            scriptName: configuration.scriptName
        ) else {
            throw Errors.generatingInjectionKeys
        }

        let keysCommand = await sourcery.generateCode(
            templatePaths: injectionKeysCommand.templates,
            sourcePaths: injectionKeysCommand.sources,
            outputPath: injectionKeysCommand.output,
            args: injectionKeysCommand.args,
            trimSourceryHeader: false
        )

        switch print {
        case .verbose: handleVerbose(command: keysCommand)
        case .interactive: shell.clear(numberOfLines: 1)
        case .standard: break
        }

        guard keysCommand.succeeded else { throw Errors.generatingInjectionKeys }
        shell.print(color: .green, text: "✅ Generated Injection Keys")

        // Generate Mocks

        shell.print(color: .yellow, text: "Generating Mock Files...")
        guard let mocksCommandInput = generateMocks(
            sourcesPath: sourcesPath,
            generatedFilesPath: mocksPath,
            scriptName: configuration.scriptName
        ) else {
            throw Errors.generatingMocks
        }

        let mocksCommand = await sourcery.generateCode(
            templatePaths: mocksCommandInput.templates,
            sourcePaths: mocksCommandInput.sources,
            outputPath: mocksCommandInput.output,
            args: mocksCommandInput.args,
            trimSourceryHeader: false
        )
        switch print {
        case .verbose: handleVerbose(command: mocksCommand)
        case .interactive: shell.clear(numberOfLines: 1)
        case .standard: break
        }

        guard mocksCommand.succeeded else { throw Errors.generatingMocks }
        shell.print(color: .green, text: "✅ Generated Mocks")

        // Generate Mock Keys

        shell.print(color: .yellow, text: "Generating Mock Keys...")
        guard let mockKeysCommandInput = generateMockKeys(
            sourcesPath: sourcesPath,
            generatedFilesPath: testKeysPath,
            scriptName: configuration.scriptName
        ) else {
            throw Errors.generatingMockKeys
        }

        let mockKeysCommand = await sourcery.generateCode(
            templatePaths: mockKeysCommandInput.templates,
            sourcePaths: mockKeysCommandInput.sources,
            outputPath: mockKeysCommandInput.output,
            args: mockKeysCommandInput.args,
            trimSourceryHeader: false
        )
        switch print {
        case .verbose: handleVerbose(command: mockKeysCommand)
        case .interactive: shell.clear(numberOfLines: 1)
        case .standard: break
        }

        guard mockKeysCommand.succeeded else { throw Errors.generatingMocks }
        shell.print(color: .green, text: "✅ Generated Mock Keys")
    }

    func build(at path: URL, with configuration: ScriptConfiguration?, print: PrintType) async throws {
        let config = try configuration ?? readScriptConfiguration(at: path)
        if fileUtility.fileExists(at: path.appending(path: config.scriptName)) {
            fileUtility.deleteFile(at: path.appending(path: config.scriptName))
        }
        let command = "cd \(path.getFullPath());swift build --configuration release; cp -f .build/release/\(config.scriptName) ./\(config.scriptName)"
        shell.print(color: .yellow, text: "Building script...")
        let commandOutput = await shell.run(command: command, shellType: .zsh)

        switch print {
        case .verbose: handleVerbose(command: commandOutput)
        case .interactive: shell.clear(numberOfLines: 1)
        case .standard: break
        }

        guard commandOutput.succeeded else { throw Errors.buildingScript }

        shell.print(color: .green, text: "✅ Script Built")
    }

    func readScriptConfiguration(
        at path: URL
    ) throws -> ScriptConfiguration {
        let configurationPath = path.appending(path: ".swiftyScriptyConfig.yml")
        guard
            fileUtility.fileExists(at: configurationPath),
            let config = fileUtility.readFile(at: configurationPath)
        else {
            throw Errors.notAScript
        }

        do {
            return try YAMLDecoder().decode(ScriptConfiguration.self, from: config)
        } catch {
            throw Errors.wrongConfigurationFile
        }
    }

    func generateInjectionKeysConfigurationFile(
        sourcesPath: URL,
        generatedFilesPath: URL,
        scriptName: String
    ) -> SourceryCommand? {
        guard let injectionKeysPath else { return nil }
        
        return SourceryCommand(
            sources: [sourcesPath],
            templates: [injectionKeysPath],
            output: generatedFilesPath,
            args: [SourceryWrapperArguments(key: Constants.nameArgument, value: scriptName)]
        )
    }

    func generateMocks(
        sourcesPath: URL,
        generatedFilesPath: URL,
        scriptName: String
    ) -> SourceryCommand? {
        guard let mocksPath else { return nil }
        
        return SourceryCommand(
            sources: [sourcesPath],
            templates: [mocksPath],
            output: generatedFilesPath,
            args: [SourceryWrapperArguments(key: Constants.nameArgument, value: scriptName)]
        )
    }

    func generateMockKeys(
        sourcesPath: URL,
        generatedFilesPath: URL,
        scriptName: String
    ) -> SourceryCommand? {
        guard let mockKeysPath else { return nil }

        return SourceryCommand(
            sources: [sourcesPath],
            templates: [mockKeysPath],
            output: generatedFilesPath,
            args: [SourceryWrapperArguments(key: Constants.nameArgument, value: scriptName)]
        )
    }

    private func handleVerbose(command: Command?) {
        guard let command else { return }

        shell.print(color: .clear, text: command.output)
        if !command.succeeded {
            shell.print(color: .red, text: command.errorOutput)
        }
    }
}

extension SetupScriptImpl {
    enum Errors: LocalizedError {
        case notAScript
        case wrongConfigurationFile
        case generatingInjectionKeys
        case generatingMocks
        case generatingMockKeys
        case buildingScript
        
        var errorDescription: String? {
            switch self {
            case .notAScript:
                return "This folder does not contain a script"
            case .wrongConfigurationFile:
                return "Wrong configuration file"
            case .generatingInjectionKeys:
                return "Could not generate Injection Keys for script"
            case .generatingMocks:
                return "Could not generate Mocks for script"
            case .generatingMockKeys:
                return "Could not generate Keys associated to mocks"
            case .buildingScript:
                return "Could not build script"
            }
        }
    }
}

struct SourceryCommand {
    let sources: [URL]
    let templates: [URL]
    let output: URL
    let args: [SourceryWrapperArguments]
}

public struct ScriptConfiguration: Codable {
    enum CodingKeys: String, CodingKey {
        case scriptName = "name"
        case sources
        case injectionKeysPath = "generated-injection-keys-path"
        case mocksPath = "generated-mocks-path"
        case mockKeysPath = "generated-mock-keys-path"
    }

    let scriptName: String
    let sources: String
    let injectionKeysPath: String
    let mocksPath: String
    let mockKeysPath: String
}
