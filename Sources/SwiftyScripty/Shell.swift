import Foundation
import RegexBuilder

/// Represents the result of a shell command execution.
public struct Command {
    /// The standard output of the command.
    public let output: String

    /// The error output of the command.
    public let errorOutput: String

    /// The exit code of the command.
    public let exitCode: Int32

    /// Indicates whether the command succeeded.
    public var succeeded: Bool {
        return exitCode == .successExitCode
    }

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

// MARK: - Shell Protocol

/// A protocol defining the interface for executing shell commands.
//sourcery: AutoMockable
public protocol Shell {
    /// Executes a bash command and returns the output.
    ///
    /// - Parameter command: The bash command to execute.
    /// - Returns: The standard output of the command.
    func bash(command: String) -> String?

    /// Executes a bash command and returns the command result.
    ///
    /// - Parameter command: The bash command to execute.
    /// - Returns: A `Command` struct with the result of the command execution.
    func bashWithExitCode(command: String) -> Command?

    /// Executes a bash command and returns the exit code.
    ///
    /// - Parameter command: The bash command to execute.
    /// - Returns: The exit code of the command.
    @discardableResult
    func runBash(command: String) -> Int32?

    /// Executes a zsh command and returns the output.
    ///
    /// - Parameter command: The zsh command to execute.
    /// - Returns: The standard output of the command.
    func zsh(command: String) -> String?

    /// Executes a zsh command and returns the command result.
    ///
    /// - Parameter command: The zsh command to execute.
    /// - Returns: A `Command` struct with the result of the command execution.
    func zshWithExitCode(command: String) -> Command?

    /// Executes a zsh command and returns the exit code.
    ///
    /// - Parameter command: The zsh command to execute.
    /// - Returns: The exit code of the command.
    @discardableResult
    func runZsh(command: String) -> Int32?

    /// Reads a zsh variable.
    ///
    /// - Parameter key: The key of the zsh variable to read.
    /// - Returns: The value of the zsh variable.
    func readZshVar(key: String) -> String?

    /// Reads a bash variable.
    ///
    /// - Parameter key: The key of the bash variable to read.
    /// - Returns: The value of the bash variable.
    func readBashVar(key: String) -> String?

    /// Asks a question to the user and returns the response.
    ///
    /// - Parameter question: The question to ask.
    /// - Returns: The user's response.
    func askQuestion(question: String) -> String?

    /// Asks for permission with a question and returns the user's decision.
    ///
    /// - Parameter question: The question to ask for permission.
    /// - Returns: `true` if the user grants permission, `false` otherwise.
    func askPermission(question: String) -> Bool

    /// Prints text with a specific color.
    ///
    /// - Parameters:
    ///   - color: The color to use for printing.
    ///   - text: The text to print.
    func print(color: ANSIColors, text: String)

    /// Removes the specified number of lines from the output.
    ///
    /// - Parameter numberOfLines: The number of lines to remove.
    func clear(numberOfLines: Int)

    /// Exits the application with a specific exit code.
    ///
    /// - Parameter code: The exit code.
    func exit(with code: Int32)
}

// MARK: - Shell Implementation

/// An implementation of the `Shell`.
class ShellImpl {
    
    // MARK: Constants
    
    /// A token used to identify the start of an interactive shell script output.
    let scriptStartToken = "<--Swift Script Interactive Shell Start-->"

    // MARK: Launch Paths
    
    /// Enumerates the launch paths for different shell environments.
    enum LaunchPaths: String {
        /// The launch path for the Zsh shell.
        case zsh = "/bin/zsh"

        /// The launch path for the Bash shell.
        case bash = "/bin/bash"
    }
    
    // MARK: Functions
    
    /// Executes a shell command and returns the command result.
    ///
    /// - Parameters:
    ///   - launchPath: The launch path for the shell.
    ///   - command: The command to execute.
    ///   - returnOutput: A boolean indicating whether to return the output.
    /// - Returns: A `Command` struct with the result of the command execution.
    func runCommand(launchPath: LaunchPaths, command: String, returnOutput: Bool) -> Command {
        // Create the filtered command and configure process and pipe.
        let newCommand: String
        if returnOutput {
            newCommand = "echo \"\(scriptStartToken)\";"+command
        } else {
            newCommand = command
        }
        let (process, pipe, errorPipe) = configureStandardProcessAndPipe(
            launchPath: launchPath,
            command: newCommand
        )

        // Create the output handlers for normal and error output.
        let outputHandler = pipe.fileHandleForReading
        let errorOutputHandler = errorPipe.fileHandleForReading
        var output: String = ""
        var errorOutput: String = ""
        
        // Add the handler closure for the output.
        outputHandler.readabilityHandler = { pipe in
            if let string = String(data: pipe.availableData, encoding: .utf8), !string.isEmpty {
                if returnOutput {
                    output.append(string)
                } else {
                    Swift.print(string)
                }
            }
        }

        // Add the handler closure for the error output.
        errorOutputHandler.readabilityHandler = { pipe in
            if let string = String(data: pipe.availableData, encoding: .utf8), !string.isEmpty {
                if returnOutput {
                    errorOutput.append(string)
                } else {
                    Swift.print(string)
                }
            }
        }

        // Start the process.
        process.launch()
        process.waitUntilExit()
        
        // Filter and return the output.
        if returnOutput { output = filterOutput(output: output) }
        return Command(
            output: output,
            errorOutput: errorOutput,
            exitCode: process.terminationStatus
        )
    }

    /// Filters the command output to remove the script start token.
    ///
    /// - Parameter output: The output to filter.
    /// - Returns: The filtered output.
    func filterOutput(output: String) -> String {
        let lines = output.components(separatedBy: "\n")
        var startIndex: Int?

        for (index, line) in lines.enumerated() {
            if line.contains(scriptStartToken) {
                startIndex = index + 1
            }
        }

        if let startIndex {
            return lines[startIndex...].joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            return output
        }
    }
    
    /// Configures and returns a standard process and pipes for command execution.
    ///
    /// - Parameters:
    ///   - launchPath: The launch path for the shell.
    ///   - command: The command to execute.
    /// - Returns: A tuple containing the process, output pipe, and error pipe.
    func configureStandardProcessAndPipe(
        launchPath: LaunchPaths,
        command: String
    ) -> (process: Process, pipe: Pipe, errorPipe: Pipe) {
        let process = Process()
        let pipe = Pipe()
        let errorPipe = Pipe()
        
        process.standardInput = nil
        process.standardOutput = pipe
        process.standardError = errorPipe
        process.launchPath = launchPath.rawValue
        #if DEBUG
        process.arguments = ["-i", "-l", "-c", command]
        #else
        process.arguments = ["-c", command]
        #endif
        return (process, pipe, errorPipe)
    }
    
    /// Runs a shell command and returns the exit code.
    ///
    /// - Parameters:
    ///   - launchPath: The launch path for the shell.
    ///   - command: The command to execute.
    /// - Returns: The exit code of the command execution.
    func runShellCommand(
        launchPath: LaunchPaths,
        command: String
    ) -> Int32? {
        runCommand(
            launchPath: launchPath,
            command: command,
            returnOutput: false
        ).exitCode
    }

    /// Runs a shell command and returns the command result.
    ///
    /// - Parameters:
    ///   - launchPath: The launch path for the shell.
    ///   - command: The command to execute.
    /// - Returns: A `Command` struct with the result of the command execution.
    func runReturningShellCommand(
        launchPath: LaunchPaths,
        command: String
    ) -> Command? {
        runCommand(
            launchPath: launchPath,
            command: command,
            returnOutput: true
        )
    }
    
    /// Reads a shell variable.
    ///
    /// - Parameters:
    ///   - launchPath: The launch path for the shell.
    ///   - key: The variable key.
    /// - Returns: The value of the variable.
    private func readShellVar(launchPath: LaunchPaths, key: String) -> String? {
        guard
            let output = runReturningShellCommand(
                launchPath: launchPath,
                command: "echo $\(key)"
            )?.output,
            !output.isEmpty
        else {
            return nil
        }
        
        return output
    }
}

// MARK: - Shell Protocol Conformance

extension ShellImpl: Shell {
    func bash(command: String) -> String? {
        runReturningShellCommand(
            launchPath: .bash,
            command: command
        )?.output
    }

    func bashWithExitCode(command: String) -> Command? {
        runReturningShellCommand(
            launchPath: .bash,
            command: command
        )
    }

    @discardableResult
    func runBash(command: String) -> Int32? {
        runShellCommand(
            launchPath: .bash,
            command: command
        )
    }

    func zsh(command: String) -> String? {
        runReturningShellCommand(
            launchPath: .zsh,
            command: command
        )?.output
    }

    func zshWithExitCode(command: String) -> Command? {
        runReturningShellCommand(
            launchPath: .zsh,
            command: command
        )
    }

    @discardableResult
    func runZsh(command: String) -> Int32? {
        runShellCommand(
            launchPath: .zsh,
            command: command
        )
    }
    
    func readZshVar(key: String) -> String? {
        readShellVar(launchPath: .zsh, key: key)
    }
    
    func readBashVar(key: String) -> String? {
        readShellVar(launchPath: .bash, key: key)
    }
    
    func askQuestion(question: String) -> String? {
        print(color: .yellow, text: question)
        return readLine()
    }
    
    func askPermission(question: String) -> Bool {
        guard let answer = askQuestion(question: question) else {
            return false
        }
        
        return answer.lowercased() == "yes" || answer.lowercased() == "y"
    }
    
    func print(color: ANSIColors, text: String) {
        #if DEBUG
        Swift.print("\(color.debugEmoji) \(text)")
        #else
        Swift.print(color.rawValue + text + ANSIColors.clear.rawValue)
        #endif
    }

    func clear(numberOfLines: Int) {
        for _ in 0..<numberOfLines {
            // Move cursor up one line.
            Swift.print("\u{1B}[1A", terminator: "")
            // Clear the line.
            Swift.print("\u{1B}[2K", terminator: "")
        }
    }

    func exit(with code: Int32) {
        Foundation.exit(code)
    }
}
