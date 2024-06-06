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
    /// - Returns: `true` if code generation succeeds, `false` otherwise.
    func generateCode(
        configPath: URL,
        args: [SourceryWrapperArguments]
    ) -> Bool

    /// Generates code based on template and source files.
    ///
    /// - Parameters:
    ///   - templatePaths: The URLs of the Sourcery templates.
    ///   - sourcePaths: The URLs of the source files to process.
    ///   - outputPath: The URL of the output directory.
    ///   - args: Additional arguments to customize the code generation process.
    /// - Returns: `true` if code generation succeeds, `false` otherwise.
    func generateCode(
        templatePaths: [URL],
        sourcePaths: [URL],
        outputPath: URL,
        args: [SourceryWrapperArguments]
    ) -> Bool
}

public extension SourceryWrapper {
    /// Generates code based on a configuration file with default arguments.
    ///
    /// - Parameters:
    ///   - configPath: The URL of the Sourcery configuration file.
    ///   - args: Additional arguments to customize the code generation process.
    /// - Returns: `true` if code generation succeeds, `false` otherwise.
    func generateCode(
        configPath: URL,
        args: [SourceryWrapperArguments] = []
    ) -> Bool {
        generateCode(configPath: configPath, args: args)
    }

    /// Generates code based on template and source files with default arguments.
    ///
    /// - Parameters:
    ///   - templatePath: The URL of the Sourcery template.
    ///   - sourcePath: The URL of the source file to process.
    ///   - outputPath: The URL of the output directory.
    ///   - args: Additional arguments to customize the code generation process.
    /// - Returns: `true` if code generation succeeds, `false` otherwise.
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

// MARK: - SourceryWrapper Implementation

/// An implementation of the `SourceryWrapper` protocol.
public struct SourceryWrapperImpl: SourceryWrapper {
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
    /// - Returns: `true` if code generation succeeds, `false` otherwise.
    public func generateCode(configPath: URL, args: [SourceryWrapperArguments]) -> Bool {
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

    /// Trims the Sourcery header from a generated file.
    ///
    /// Sourcery adds a header to generated files by default. This method removes the header from the generated file at the specified path.
    ///
    /// - Parameter path: The URL of the file to trim the header from.
    private func trimSourceryHeader(at path: URL) {
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
