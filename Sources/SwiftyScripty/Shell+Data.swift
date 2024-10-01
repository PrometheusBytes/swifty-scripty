import Foundation

/// An enum representing the type of shell that can be used.
public enum ShellType: String {
    /// The `bash` shell.
    case bash = "/bin/bash"

    /// The `zsh` shell.
    case zsh = "/bin/zsh"
}

/// Represents the result of a shell command execution.
public struct Command: Equatable {
    /// The standard output of the command.
    public let output: String

    /// The error output of the command.
    public let errorOutput: String

    /// The exit code of the command.
    public let exitCode: Int32

    /// Indicates whether the command succeeded.
    public var succeeded: Bool { exitCode == .successExitCode }

    /// Initializes a new Command instance.
    ///
    /// - Parameters:
    ///   - output: The standard output of the command.
    ///   - errorOutput: The error output of the command.
    ///   - exitCode: The exit code of the command.
    public init(output: String, errorOutput: String, exitCode: Int32) {
        self.output = output
        self.errorOutput = errorOutput
        self.exitCode = exitCode
    }

    /// A static variable representing an unknown error.
    public static let unknownError = Command(output: "", errorOutput: "Unknown Error", exitCode: 1)
}

/// Extension to provide standard exit codes.
public extension Int32 {
    /// Standard exit code indicating error.
    static let errorExitCode: Self = 1

    /// Standard exit code indicating success.
    static let successExitCode: Self = 0
}
