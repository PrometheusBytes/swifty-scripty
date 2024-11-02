import Foundation

// MARK: - ProcessRunner Protocol

/// A protocol modelling a runnable process of the system.
//sourcery: AutoMockable
public protocol ProcessRunner {
    /// Runs the passed command in a new process.
    ///
    /// - Parameters:
    ///   - command: The command to be executed in the process.
    ///   - shellType: The shell to be used to run the command.
    func run(
        command: String,
        shellType: ShellType
    ) -> SwiftyProcess
}

public extension ProcessRunner {
    /// Runs the passed command in a new process.
    ///
    /// - Parameters:
    ///   - command: The command to be executed in the process.
    ///   - shellType: The shell to be used to run the command. Defaults to `zsh`
    func run(
        command: String,
        shellType: ShellType = .zsh
    ) -> SwiftyProcess {
        run(command: command, shellType: shellType)
    }
}

// MARK: - ProcessRunner Implementation

/// An implementation of the `ProcessRunner`.
struct ProcessRunnerImpl: ProcessRunner {

    // MARK: - Properties

    /// A token used to identify the start of an interactive shell script output.
    let scriptStartToken = "<--Swift Script Interactive Shell Start-->"
}

// MARK: - ProcessRunner Protocol Conformance

extension ProcessRunnerImpl {
    func run(command: String, shellType: ShellType) -> SwiftyProcess {
        let newCommand = "echo \"\(scriptStartToken)\"; " + command
        let (process, pipe, errorPipe, inputPipe) = configureStandardProcessAndPipe(
            command: newCommand,
            shellType: shellType
        )

        let stream = AsyncStream<SwiftyProcess.Output> { continuation in
            Task {
                defer { continuation.finish() }

                async let standardOutputTask: Void = {
                    var shouldStartOutput = false
                    for try await line in pipe.fileHandleForReading.bytes.lines {
                        if shouldStartOutput {
                            continuation.yield(.output(line))
                        } else if line == scriptStartToken {
                            shouldStartOutput = true
                        }
                    }
                }()

                async let errorOutputTask: Void = {
                    for try await line in errorPipe.fileHandleForReading.bytes.lines {
                        continuation.yield(.error(line))
                    }
                }()

                do {
                    try process.run()
                    moveToForeground(process)
                    process.waitUntilExit()
                    _ = try await (standardOutputTask, errorOutputTask)
                    restoreDefaultForegroundProcess()
                    continuation.yield(.exitCode(process.terminationStatus))
                    return
                } catch {
                    continuation.yield(.failureRunningProcess(error))
                    return
                }
            }
        }

        return SwiftyProcess(
            stream: stream,
            process: process,
            inputPipe: inputPipe
        )
    }
}

// MARK: - Private Helpers

private extension ProcessRunnerImpl {
    private func configureStandardProcessAndPipe(
        command: String,
        shellType: ShellType
    ) -> (process: Process, pipe: Pipe, errorPipe: Pipe, outputPipe: Pipe) {
        let process = Process()
        let pipe = Pipe()
        let errorPipe = Pipe()
        let outputPipe = Pipe()

        process.standardOutput = pipe
        process.standardError = errorPipe
        process.launchPath = shellType.rawValue
        #if DEBUG
        process.arguments = ["-i", "-l", "-c", command]
        #else
        process.arguments = ["-c", command]
        #endif
        return (process, pipe, errorPipe, outputPipe)
    }

    private func moveToForeground(_ process: Process) {
        tcsetpgrp(STDIN_FILENO, process.processIdentifier)
        signal(SIGTTOU, SIG_IGN)
    }

    private func restoreDefaultForegroundProcess() {
        tcsetpgrp(STDIN_FILENO, getpid())
    }
}
