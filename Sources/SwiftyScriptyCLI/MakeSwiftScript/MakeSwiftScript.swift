import Foundation
import SwiftyScripty

//sourcery: AutoMockable
public protocol MakeSwiftScript {
    func createScript(with name: String, at path: URL, print: PrintType) async throws
}

struct MakeSwiftScriptImpl: MakeSwiftScript {

    // MARK: - Injected Values

    @Injected(\.shell) var shell: Shell
    @Injected(\.swiftPackage) var swiftPackage: SwiftPackage
    @Injected(\.sourceryWrapper) var sourceryWrapper: SourceryWrapper
    @Injected(\.fileUtility) var fileUtility: FileUtility
    @Injected(\.setupScript) var setupScript: SetupScript

    // MARK: - Resources

    let scriptPackagePath = Bundle.module.url(
        forResource: "ScriptPackage",
        withExtension: "stencil",
        subdirectory: "Resources/Templates/MakeSwiftScript"
    )

    let scriptMainTemplatePath = Bundle.module.url(
        forResource: "ScriptMain",
        withExtension: "stencil",
        subdirectory: "Resources/Templates/MakeSwiftScript"
    )

    let scriptMainTestsTemplatePath = Bundle.module.url(
        forResource: "ScriptMainTests",
        withExtension: "stencil",
        subdirectory: "Resources/Templates/MakeSwiftScript"
    )

    let scriptConfigurationPath = Bundle.module.url(
        forResource: "SwiftScriptConfiguration",
        withExtension: "",
        subdirectory: "Resources/Templates/MakeSwiftScript"
    )

    // MARK: - Make Script

    func createScript(with name: String, at path: URL, print: PrintType) async throws {
        shell.print(color: .yellow, text: "Creating Project Folder...")
        guard let folderPath = try await createProjectFolder(at: path, name: name, print: print) else {
            return
        }

        shell.print(color: .yellow, text: "Generating Package File...")
        guard let packageCommand = await generatePackageFile(at: folderPath, name: name) else {
            if print == .interactive { shell.clear(numberOfLines: 1) }
            throw Error.creatingPackageFile
        }
        handle(command: packageCommand, print: print, success: "Package File Generated")

        shell.print(color: .yellow, text: "Generating Main File...")
        guard let mainCommand = await generateMainFile(at: folderPath, name: name) else {
            if print == .interactive { shell.clear(numberOfLines: 1) }
            throw Error.creatingMainFile
        }
        handle(command: mainCommand, print: print, success: "Main File Generated")

        shell.print(color: .yellow, text: "Generating Main Test File...")
        guard let testCommand = await generateMainTestFile(at: folderPath, name: name) else {
            if print == .interactive { shell.clear(numberOfLines: 1) }
            throw Error.creatingMainTestFile
        }
        handle(command: testCommand, print: print, success: "Main Test File Generated")


        shell.print(color: .yellow, text: "Generating Configuration File...")
        guard generateConfigurationFile(at: folderPath, name: name) else {
            if print == .interactive { shell.clear(numberOfLines: 1) }
            throw Error.creatingConfigurationFile
        }
        if print == .interactive { shell.clear(numberOfLines: 1) }
        shell.print(color: .green, text: "✅ Configuration File Created")

        try setupScript.build(at: folderPath, print: print)
    }
    
    // MARK: - Generate Swift Package

    func createProjectFolder(at path: URL, name: String, print: PrintType) async throws -> URL? {
        let scriptPath = path.appending(path: name)
        var currentPrint = print
        if fileUtility.folderExists(at: scriptPath) {
            guard shell.askPermission(question: "WARNING: The repository already exists. Do you want to delete it? [y/n]") else {
                return nil
            }
            fileUtility.deleteFile(at: scriptPath)

            // We switch print to standard not to remove the user answer
            if print == .interactive {
                currentPrint = .standard
            }
        }

        guard fileUtility.createFolder(
            at: scriptPath,
            deleteIfExists: true
        ) else {
            throw Error.creatingProjectFolder
        }

        guard let command = await swiftPackage.initialize(at: scriptPath) else {
            if currentPrint == .interactive { shell.clear(numberOfLines: 1) }
            throw Error.creatingProjectFolder
        }
        handle(command: command, print: currentPrint, success: "Project Folder Generated")
        guard fileUtility.createFolder(
            at: scriptPath.appending(path: "Mocks"),
            deleteIfExists: true
        ) else {
            throw Error.creatingProjectFolder
        }

        return scriptPath
    }

    // MARK: - Update Package File

    func generatePackageFile(at path: URL, name: String) async -> Command? {
        guard
            let scriptPackagePath,
            fileUtility.deleteFile(at: path, name: "Package.swift")
        else {
            return nil
        }

        return await sourceryWrapper.generateCode(
            templatePath: scriptPackagePath,
            sourcePath: scriptPackagePath,
            outputPath: path.appending(path: "Package.swift"),
            args: [
                .init(key: "scriptName", value: name)
            ]
        )
    }
    
    // MARK: - Generate Main File

    func generateMainFile(at path: URL, name: String) async -> Command? {
        let mainFilePath = path.appending(path: "Sources/main.swift")
        let newFilePath = path.appending(path: "Sources/\(name)/MainScript.swift")
        guard let scriptMainTemplatePath else {
            return nil
        }

        if fileUtility.fileExists(at: mainFilePath) {
            fileUtility.deleteFile(at: mainFilePath)
        }

        if fileUtility.fileExists(at: newFilePath) {
            fileUtility.deleteFile(at: newFilePath)
        }

        return await sourceryWrapper.generateCode(
            templatePath: scriptMainTemplatePath,
            sourcePath: scriptMainTemplatePath,
            outputPath: newFilePath,
            args: [
                .init(key: "scriptName", value: name)
            ]
        )
    }

    // MARK: - Generate Main Test File

    func generateMainTestFile(at path: URL, name: String) async -> Command?  {
        let mainTestPath = path.appending(path: "Tests/\(name)Tests/\(name)Tests.swift")
        guard let scriptMainTestsTemplatePath else {
            return nil
        }

        if fileUtility.fileExists(at: mainTestPath) { fileUtility.deleteFile(at: mainTestPath) }

        return await sourceryWrapper.generateCode(
            templatePath: scriptMainTestsTemplatePath,
            sourcePath: scriptMainTestsTemplatePath,
            outputPath: mainTestPath,
            args: [
                .init(key: "scriptName", value: name)
            ]
        )
    }
    
    // MARK: - Generate Configuration File

    func generateConfigurationFile(at path: URL, name: String) -> Bool {
        let configurationPath = path.appending(path: ".swiftyScriptyConfig.yml")
        guard 
            let scriptConfigurationPath,
            let configurationFileContent = fileUtility.readFile(at: scriptConfigurationPath)
        else {
            return false
        }
        
        let newContent = configurationFileContent.replacingOccurrences(of: "{{ scriptName }}", with: name)
        if fileUtility.fileExists(at: configurationPath) { fileUtility.deleteFile(at: configurationPath) }
        return fileUtility.writeFile(content: newContent, to: configurationPath)
    }

    // MARK: - Utils

    func handle(command: Command, print: PrintType, success: String? = nil) {
        switch print {
        case .verbose:
            shell.print(color: .clear, text: command.output)
            if !command.succeeded {
                shell.print(color: .red, text: command.errorOutput)
            }
        case .interactive: shell.clear(numberOfLines: 1)
        case .standard: break
        }

        if let success { shell.print(color: .green, text: "✅ \(success)") }
    }
}

extension MakeSwiftScriptImpl {
    enum Error: LocalizedError {
        case creatingProjectFolder
        case creatingPackageFile
        case creatingMainFile
        case creatingMainTestFile
        case creatingConfigurationFile

        var errorDescription: String? {
            switch self {
            case .creatingProjectFolder:
                return "Could not create script project folder"
            case .creatingPackageFile:
                return "Could not create the package file"
            case .creatingMainFile:
                return "Could not create main file"
            case .creatingMainTestFile:
                return "Could not create main test file"
            case .creatingConfigurationFile:
                return "Could not create configuration file"
            }
        }
    }
}
