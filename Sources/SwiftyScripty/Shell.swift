import Foundation
import RegexBuilder

public struct Command {
    public let output: String
    public let errorOutput: String
    public let exitCode: Int32

    public var succeeded: Bool {
        return exitCode == .successExitCode
    }

    public init(output: String, errorOutput: String, exitCode: Int32) {
        self.output = output
        self.errorOutput = errorOutput
        self.exitCode = exitCode
    }
}

public extension Int32 {
    static let errorExitCode: Self = 1
    static let successExitCode: Self = 0
}

//sourcery: AutoMockable
public protocol Shell {
    func bash(command: String) -> String?
    func bashWithExitCode(command: String) -> Command?
    @discardableResult
    func runBash(command: String) -> Int32?
    func zsh(command: String) -> String?
    func zshWithExitCode(command: String) -> Command?
    @discardableResult
    func runZsh(command: String) -> Int32?
    func readZshVar(key: String) -> String?
    func readBashVar(key: String) -> String?
    func askQuestion(question: String) -> String?
    func askPermission(question: String) -> Bool
    func print(color: ANSIColors, text: String)
    func exit(with code: Int32)
}

class ShellImpl {
    
    // MARK: Constants
    
    static let goToRootCommand = "cd $(git rev-parse --show-toplevel)"
    let scriptStartToken = "<--Swift Script Interactive Shell Start-->"
    
    // MARK: Launch Paths
    
    enum LaunchPaths: String {
        case zsh = "/bin/zsh"
        case bash = "/bin/bash"
    }
    
    // MARK: functions
    
    func runCommand(launchPath: LaunchPaths, command: String, returnOutput: Bool) -> Command {
        // Create the filtered command and configure process and pipe
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

        // Create the output handlers for normal and error output
        let outputHandler = pipe.fileHandleForReading
        let errorOutputHandler = errorPipe.fileHandleForReading
        var output: String = ""
        var errorOutput: String = ""
        
        // Add the handler closure for the output
        outputHandler.readabilityHandler = { pipe in
            if let string = String(data: pipe.availableData, encoding: .utf8), !string.isEmpty {
                if returnOutput {
                    output.append(string)
                } else {
                    Swift.print(string)
                }
            }
        }

        // Add the handler closure for the error output
        errorOutputHandler.readabilityHandler = { pipe in
            if let string = String(data: pipe.availableData, encoding: .utf8), !string.isEmpty {
                if returnOutput {
                    errorOutput.append(string)
                } else {
                    Swift.print(string)
                }
            }
        }

        // Start the process
        process.launch()
        process.waitUntilExit()
        
        // Filter and return the output
        if returnOutput { output = filterOutput(output: output) }
        return Command(
            output: output,
            errorOutput: errorOutput,
            exitCode: process.terminationStatus
        )
    }

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

// MARK: Shell Protocol

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

    func exit(with code: Int32) {
        Foundation.exit(code)
    }
}
