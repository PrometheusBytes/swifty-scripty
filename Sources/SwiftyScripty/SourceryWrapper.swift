import Foundation

//sourcery: AutoMockable
public protocol SourceryWrapper {
    func generateCode(
        configPath: URL,
        args: [SourceryWrapperArguments]
    ) -> Bool

    func generateCode(
        templatePaths: [URL],
        sourcePaths: [URL],
        outputPath: URL,
        args: [SourceryWrapperArguments]
    ) -> Bool
}

public extension SourceryWrapper {
    func generateCode(
        configPath: URL,
        args: [SourceryWrapperArguments] = []
    ) -> Bool {
        generateCode(configPath: configPath, args: args)
    }

    func generateCode(
        templatePath: URL,
        sourcePath: URL,
        outputPath: URL,
        args: [SourceryWrapperArguments] = []
    ) -> Bool {
        generateCode(
            templatePaths: [templatePath],
            sourcePaths: [sourcePath],
            outputPath: outputPath,
            args: args
        )
    }
}

struct SourceryWrapperImpl: SourceryWrapper {
    @Injected(\.shell)
    var shell: Shell
    
    let binaryPath = Bundle.module.path(
        forResource: "sourcery",
        ofType: nil,
        inDirectory: "Resources/Binaries"
    )

    func generateCode(configPath: URL, args: [SourceryWrapperArguments]) -> Bool {
        guard let binaryPath else { return false }
        var command = "\(binaryPath) --config \(configPath.getFullPath())"
        if !args.isEmpty {
            command.append(" --args ")
            var arguments = ""
            args.forEach { argument in
                arguments.append("\(argument.key)=\(argument.value),")
            }
            command.append(arguments)
        }

        shell.runZsh(command: command)
        return true
    }

    func generateCode(
        templatePaths: [URL],
        sourcePaths: [URL],
        outputPath: URL,
        args: [SourceryWrapperArguments]
    ) -> Bool {
        guard let binaryPath else { return false }
        let templates = templatePaths.map { $0.getFullPath() }.joined(separator: " --templates ")
        let sources = sourcePaths.map { $0.getFullPath() }.joined(separator: " --sources ")

        var command = binaryPath
        command.append(" --templates \(templates)")
        command.append(" --sources \(sources)")
        command.append(" --output \(outputPath.getFullPath())")
        if !args.isEmpty {
            command.append(" --args ")
            var arguments = ""
            args.forEach { argument in
                arguments.append("\(argument.key)=\(argument.value),")
            }
            command.append(arguments)
        }

        guard shell.runZsh(command: command) == .successExitCode else {
            return false
        }
        trimSourceryHeader(at: outputPath)

        return true
    }

    private func trimSourceryHeader(at path: URL) {
        guard let fileContent = try? String(contentsOfFile: path.absoluteString) else {
            return
        }

        var fileLines = fileContent.split(separator: "\n")
        fileLines.removeFirst(2)
        let text = fileLines.joined(separator: "\n")

        do {
            try text.write(toFile: path.absoluteString, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
}

public struct SourceryWrapperArguments {
    let key: String
    let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
