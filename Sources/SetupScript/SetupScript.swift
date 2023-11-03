import ArgumentParser
import Foundation
import SwiftyScripty

@main
struct MakeSwiftScript: ParsableCommand {
    enum CodingKeys: CodingKey {
        case path
    }
    
    // MARK: - Arguments
    
    @Option(name: .shortAndLong, help: "The path of the Swift Script Folder.")
    var path: String
    
    // MARK: - Injected Values
    
    @Injected(\.shell) var shell: Shell
    @Injected(\.repository) var repository: Repository
    @Injected(\.sourceryWrapper) var sourcery: SourceryWrapper
    
    mutating func run() throws {
        let scriptPath = URL(filePath: path)
        guard
            let injectionKeysCommand = generateInjectionKeysConfigurationFile(path: scriptPath),
            sourcery.generateCode(
                templatePaths: injectionKeysCommand.templates,
                sourcePaths: injectionKeysCommand.sources,
                outputPath: injectionKeysCommand.output,
                args: injectionKeysCommand.args
            )
        else {
            shell.print(color: .red, text: "ERROR: Could not generate Injection Keys")
            shell.exit(with: .errorExitCode)
            return
        }

        guard
            let mocksCommand = generateMocks(path: scriptPath),
            sourcery.generateCode(
                templatePaths: mocksCommand.templates,
                sourcePaths: mocksCommand.sources,
                outputPath: mocksCommand.output,
                args: mocksCommand.args
            )
        else {
            shell.print(color: .red, text: "ERROR: Could not generate Mocks")
            shell.exit(with: .errorExitCode)
            return
        }
    }
    
    func generateInjectionKeysConfigurationFile(path: URL) -> SourceryCommand? {
        let scriptName = path.lastPathComponent
        guard
            let templates = repository.path(of: .templates),
            let sourcePath = URL(string: "\(path.path())/Sources"),
            let templatePath = URL(string: "\(templates.absoluteString)/Sourcery/InjectionKeys.stencil"),
            let output = URL(string: "\(path.path())/Sources/\(scriptName)/Generated/InjectionKeys")
        else {
            return nil
        }
        
        return SourceryCommand(
            sources: [sourcePath],
            templates: [templatePath],
            output: output,
            args: [.init(key: "scriptName", value: scriptName)]
        )
    }

    func generateMocks(path: URL) -> SourceryCommand? {
        let scriptName = path.lastPathComponent
        guard
            let templates = repository.path(of: .templates),
            let sourcePath = URL(string: "\(path.path())/Sources/\(scriptName)"),
            let templatePath = URL(string: "\(templates.absoluteString)/Sourcery/AutoMockable.stencil"),
            let output = URL(string: "\(path.path())/Sources/\(scriptName)/Generated/Mocks")
        else {
            return nil
        }
        
        return SourceryCommand(
            sources: [sourcePath],
            templates: [templatePath],
            output: output,
            args: [
                .init(key: "import", value: "Foundation")
            ]
        )
    }
}

struct SourceryCommand {
    let sources: [URL]
    let templates: [URL]
    let output: URL
    let args: [SourceryWrapperArguments]
}
