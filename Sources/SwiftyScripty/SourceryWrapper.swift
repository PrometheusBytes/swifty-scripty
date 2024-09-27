import Foundation

// MARK: - SourceryWrapper Protocol

/// A protocol for generating code using Sourcery.
///
/// This protocol defines methods for generating code from various configurations and templates.
//sourcery: AutoMockable
public protocol SourceryWrapper {
    /// Generates code based on a configuration file.
    ///
    /// - Parameters:
    ///   - configPath: The URL of the Sourcery configuration file.
    ///   - args: Additional arguments to customize the code generation process.
    /// - Returns: The Command output generated from sourcery.
    func generateCode(
        configPath: URL,
        args: [SourceryWrapperArguments]
    ) async -> Command

    /// Generates code based on template and source files.
    ///
    /// - Parameters:
    ///   - templatePaths: The URLs of the Sourcery templates.
    ///   - sourcePaths: The URLs of the source files to process.
    ///   - outputPath: The URL of the output directory.
    ///   - args: Additional arguments to customize the code generation process.
    ///   - trimSourceryHeader: `Bool`, indicates whether to remove the sourcery header or not.
    /// - Returns: The Command output generated from sourcery.
    func generateCode(
        templatePaths: [URL],
        sourcePaths: [URL],
        outputPath: URL,
        args: [SourceryWrapperArguments],
        trimSourceryHeader: Bool
    ) async -> Command
}

public extension SourceryWrapper {
    /// Generates code based on a configuration file with default arguments.
    ///
    /// - Parameters:
    ///   - configPath: The URL of the Sourcery configuration file.
    ///   - args: Additional arguments to customize the code generation process, defaults to empty.
    /// - Returns: The Command output generated from sourcery.
    func generateCode(
        configPath: URL,
        args: [SourceryWrapperArguments] = []
    ) async -> Command {
        await generateCode(configPath: configPath, args: args)
    }

    /// Generates code based on template and source files with default arguments.
    ///
    /// - Parameters:
    ///   - templatePath: The URL of the Sourcery template.
    ///   - sourcePath: The URL of the source file to process.
    ///   - outputPath: The URL of the output directory.
    ///   - args: Additional arguments to customize the code generation process.
    ///   - trimSourceryHeader: `Bool`, indicates whether to remove the sourcery header or not. Defaults to false.
    /// - Returns: `true` if code generation succeeds, `false` otherwise.
    func generateCode(
        templatePath: URL,
        sourcePath: URL,
        outputPath: URL,
        args: [SourceryWrapperArguments] = [],
        trimSourceryHeader: Bool = false
    ) async -> Command {
        await generateCode(
            templatePaths: [templatePath],
            sourcePaths: [sourcePath],
            outputPath: outputPath,
            args: args,
            trimSourceryHeader: trimSourceryHeader
        )
    }
}

// MARK: - SourceryWrapper Implementation

/// An implementation of the `SourceryWrapper` protocol.
public struct SourceryWrapperImpl: SourceryWrapper {
    /// The shell utility used to execute commands.
    @Injected(\.shell) var shell: Shell
    
    /// The path to the Sourcery binary.
    let binaryPath = Bundle.module.path(
        forResource: "sourcery",
        ofType: nil,
        inDirectory: "Resources/Binaries"
    )

    /// Generates code based on a configuration file.
    ///
    /// - Parameters:
    ///   - configPath: The URL of the Sourcery configuration file.
    ///   - args: Additional arguments to customize the code generation process.
    ///   - trimSourceryHeader: `Bool`, indicates whether to remove the sourcery header or not.
    /// - Returns: The Command output generated from sourcery.
    public func generateCode(
        configPath: URL,
        args: [SourceryWrapperArguments]
    ) async -> Command {
        guard let binaryPath else { return .unknownError }

        let command = "\(binaryPath) --config \(configPath.getFullPath())".append(arguments: args)
        return await shell.run(command: command)
    }

    /// Generates code based on template and source files.
    ///
    /// - Parameters:
    ///   - templatePaths: The URLs of the Sourcery templates.
    ///   - sourcePaths: The URLs of the source files to process.
    ///   - outputPath: The URL of the output directory.
    ///   - args: Additional arguments to customize the code generation process.
    /// - Returns: `true` if code generation succeeds, `false` otherwise.
    public func generateCode(
        templatePaths: [URL],
        sourcePaths: [URL],
        outputPath: URL,
        args: [SourceryWrapperArguments],
        trimSourceryHeader: Bool
    ) async -> Command {
        guard let binaryPath else { return .unknownError }
        let templates = templatePaths.map { $0.getFullPath() }.joined(separator: " --templates ")
        let sources = sourcePaths.map { $0.getFullPath() }.joined(separator: " --sources ")

        var command = binaryPath
        command.append(" --templates \(templates)")
        command.append(" --sources \(sources)")
        command.append(" --output \(outputPath.getFullPath())")
        command = command.append(arguments: args)

        let commandOutput = await shell.run(command: command)

        if commandOutput.succeeded, trimSourceryHeader {
            trimHeader(at: outputPath)
        }

        return commandOutput
    }
}


// MARK: - Helper Functions

private extension String {
    func append(arguments: [SourceryWrapperArguments]) -> String {
        guard !arguments.isEmpty else { return self }

        var toRet = self
        toRet.append(" --args ")
        toRet.append(arguments.map({ "\($0.key)=\($0.value)" }).joined(separator: ","))
        return toRet
    }
}

private extension SourceryWrapperImpl {
    func trimHeader(at path: URL) {
        guard let fileContent = try? String(contentsOfFile: path.getFullPath()) else {
            return
        }

        var fileLines = fileContent.split(separator: "\n")
        fileLines.removeFirst(2)
        let text = fileLines.joined(separator: "\n")

        do {
            try text.write(toFile: path.getFullPath(), atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
}

/// Represents an argument for Sourcery code generation.
public struct SourceryWrapperArguments {
    /// The key of the argument.
    let key: String

    /// The value of the argument.
    let value: String

    /// Initializes a new `SourceryWrapperArguments`.
    ///
    /// - Parameters:
    ///   - key: The key of the argument.
    ///   - value: The value of the argument.
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
