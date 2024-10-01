import Foundation
import RegexBuilder

// MARK: - Shell Protocol

/// A protocol defining the interface for executing shell commands.
//sourcery: AutoMockable
public protocol Shell {
    /// Executes a shell command and returns the command result.
    ///
    /// - Parameters:
    ///   - command: The command to execute.
    ///   - shellType: The type of shell to use.
    /// - Returns: A `Command` struct with the result of the command execution.
    func run(command: String, shellType: ShellType) async -> Command

    /// Reads a zsh variable.
    ///
    /// - Parameter key: The key of the zsh variable to read.
    /// - Returns: The value of the zsh variable.
    func readZshVar(key: String) async -> String?

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

public extension Shell {
    /// Executes a shell command and returns the command result.
    ///
    /// - Parameters:
    ///   - command: The command to execute.
    ///   - shellType: The type of shell to use. Defaults to `zsh`.
    /// - Returns: A `Command` struct with the result of the command execution.
    func run(
        command: String,
        shellType: ShellType = .zsh
    ) async -> Command {
        await run(command: command, shellType: shellType)
    }
}

// MARK: - Shell Implementation

/// An implementation of the `Shell`.
class ShellImpl {
    // MARK: - Properties

    @Injected(\.processRunner) var runner: ProcessRunner

}

// MARK: - Shell Protocol Conformance

extension ShellImpl: Shell {
    func run(command: String, shellType: ShellType) async -> Command {
        let process = runner.run(command: command, shellType: shellType)

        var output: String = ""
        var errorOutput: String = ""
        var exitCode: Int32 = 0

        for await value in process.stream {
            switch value {
            case let .output(data): output.append(data)
            case let .error(data): errorOutput.append(data)
            case .failureRunningProcess: exitCode = 1
            case let .exitCode(value): exitCode = value
            }
        }

        return Command(
            output: output,
            errorOutput: errorOutput,
            exitCode: exitCode
        )
    }

    func readZshVar(key: String) async -> String? {
        await run(command: "echo $\(key)").output
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
