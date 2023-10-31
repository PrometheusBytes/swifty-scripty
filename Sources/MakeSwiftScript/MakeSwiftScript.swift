import ArgumentParser
import Foundation
import SwiftyScripty

@main
struct MakeSwiftScript: ParsableCommand {
    enum CodingKeys: CodingKey {
        case path
        case name
        case forceDeletion
    }
    
    // MARK: - Arguments

    @Option(name: .shortAndLong, help: "The path where to create the script.")
    var path: String

    @Option(name: .shortAndLong, help: "The name of the script.")
    var name: String

    @Flag(help: "Whether to force the deletion of the path or not")
    var forceDeletion = false

    // MARK: - Injected Values

    @Injected(\.shell) var shell: Shell
    @Injected(\.repository) var repository: Repository
    @Injected(\.swiftPackage) var swiftPackage: SwiftPackage
    @Injected(\.sourceryWrapper) var sourceryWrapper: SourceryWrapper

    mutating func run() throws {
        guard let folderPath = createProjectFolder(at: path, name: name) else {
            shell.print(color: .red, text: "ERROR: Unable to create project folder")
            shell.exit(with: .errorExitCode)
            return
        }

        guard generatePackageFile(at: folderPath, name: name) else {
            shell.print(color: .red, text: "ERROR: Unable to generate package file")
            shell.exit(with: .errorExitCode)
            return
        }

        guard generateMakefile(at: folderPath, name: name) else {
            shell.print(color: .red, text: "ERROR: Unable to generate makefile")
            shell.exit(with: .errorExitCode)
            return
        }

        guard generateMainFile(at: folderPath, name: name) else {
            shell.print(color: .red, text: "ERROR: Unable to generate main file")
            shell.exit(with: .errorExitCode)
            return
        }

        guard generateRegistratorFile(at: folderPath, name: name) else {
            shell.print(color: .red, text: "ERROR: Unable to generate registrator file")
            shell.exit(with: .errorExitCode)
            return
        }

        guard generateMainTestFile(at: folderPath, name: name) else {
            shell.print(color: .red, text: "ERROR: Unable to generate main test file")
            shell.exit(with: .errorExitCode)
            return
        }

        shell.runZsh(command: "cd \(folderPath); make build")
    }
    
    // MARK: - Generate Swift Package

    func createProjectFolder(at path: String, name: String) -> URL? {
        guard let scriptPath = URL(string: "\(path)/\(name)") else {
            return nil
        }

        if repository.folderExists(at: scriptPath), !forceDeletion {
            guard shell.askPermission(question: "WARNING: The repository already exists. Do you want to delete it? [y/n]") else {
                return nil
            }
        }
        
        guard repository.createFolder(
            at: scriptPath,
            deleteIfExists: true
        ) else {
            return nil
        }

        swiftPackage.initialize(at: scriptPath)
        return scriptPath
    }

    // MARK: - Update Package File

    func generatePackageFile(at path: URL, name: String) -> Bool {
        guard
            let templatePath = repository.path(of: .makeSwiftScriptTemplates)
        else {
            return false
        }

        repository.deleteFile(at: path, name: "Package.swift")
        return sourceryWrapper.generateCode(
            templatePath: templatePath.appendPath("ScriptPackage.stencil"),
            sourcePath: templatePath.appendPath("ScriptPackage.stencil"),
            outputPath: path.appendPath("Package.swift"),
            args: [
                .init(key: "scriptName", value: name)
            ]
        )
    }

    // MARK: - Generate Makefile

    func generateMakefile(at path: URL, name: String) -> Bool {
        repository.deleteFile(at: path, name: "Makefile")
        guard
            let root = repository.path(of: .root),
            let templatePath = repository.path(of: .makeSwiftScriptTemplates),
            repository.copyFile(
                from: templatePath.appendPath("SwiftScriptMakefile"),
                to: path.appendPath("Makefile")
            )
        else {
            return false
        }

        guard let fileContent = repository.readFile(from: path.appendPath("Makefile")) else {
            return false
        }

        let newContent = fileContent
            .replacingOccurrences(
                of: "{{ scriptName }}",
                with: name
            )
            .replacingOccurrences(
                of: "{{ swiftyScriptyDir }}",
                with: root.absoluteString
            )
        return repository.replaceFileContent(from: path.appendPath("Makefile"), with: newContent)
    }
    
    // MARK: - Generate Main File

    func generateMainFile(at path: URL, name: String) -> Bool {
        let mainFilePath = path.appendPath("Sources/main.swift")
        let newFilePath = path.appendPath("Sources/\(name)/\(name).swift")
        guard let templatePath = repository.path(of: .makeSwiftScriptTemplates) else {
            return false
        }

        if repository.fileExists(at: mainFilePath) {
            repository.delete(at: mainFilePath)
        }

        if repository.fileExists(at: newFilePath) {
            repository.delete(at: newFilePath)
        }

        return sourceryWrapper.generateCode(
            templatePath: templatePath.appendPath("ScriptMain.stencil"),
            sourcePath: templatePath.appendPath("ScriptMain.stencil"),
            outputPath: newFilePath,
            args: [
                .init(key: "scriptName", value: name)
            ]
        )
    }

    // MARK: - Generate Registrator File

    func generateRegistratorFile(at path: URL, name: String) -> Bool {
        let mainFilePath = path.appendPath("Sources/TestUtils/Registrator.swift")
        guard
            let templatePath = repository.path(of: .makeSwiftScriptTemplates)
        else {
            return false
        }
        
        if repository.fileExists(at: mainFilePath) { repository.delete(at: mainFilePath) }

        return sourceryWrapper.generateCode(
            templatePath: templatePath.appendPath("ScriptRegistrator.stencil"),
            sourcePath: templatePath.appendPath("ScriptRegistrator.stencil"),
            outputPath: mainFilePath,
            args: [
                .init(key: "scriptName", value: name)
            ]
        )
    }

    // MARK: - Generate Main Test File

    func generateMainTestFile(at path: URL, name: String) -> Bool {
        let mainTestPath = path.appendPath("Tests/\(name)Tests/\(name)Tests.swift")
        guard
            let templatePath = repository.path(of: .makeSwiftScriptTemplates)
        else {
            return false
        }

        if repository.fileExists(at: mainTestPath) { repository.delete(at: mainTestPath) }

        return sourceryWrapper.generateCode(
            templatePath: templatePath.appendPath("ScriptMainTests.stencil"),
            sourcePath: templatePath.appendPath("ScriptMainTests.stencil"),
            outputPath: mainTestPath,
            args: [
                .init(key: "scriptName", value: name)
            ]
        )
    }
}
