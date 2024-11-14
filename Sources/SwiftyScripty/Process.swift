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
    func run(command: String, shellType: ShellType) -> SwiftyProcess {
        let (process, pipe, errorPipe, inputPipe) = configureStandardProcessAndPipe(
            command: buildCommand(from: command),
            shellType: shellType
        )

        let stream = AsyncStream<SwiftyProcess.Output> { stream in
            Task {
                defer { stream.finish() }

                async let pipeReadTask = pipeTask(for: pipe, and: stream)
                async let errorPipeReadTask = errorPipeTask(for: errorPipe, and: stream)

                do {
                    try process.run()
                    moveToForeground(process)
                    process.waitUntilExit()
                    restoreDefaultForegroundProcess()
                    _ = try? await (pipeReadTask.value, errorPipeReadTask.value)
                    return
                } catch {
                    stream.yield(.failureRunningProcess(error))
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
    private func pipeTask(
        for pipe: Pipe,
        and stream: AsyncStream<SwiftyProcess.Output>.Continuation
    ) -> Task<Void, any Error> {
        TaskProvider.cancellableContinuationTask { continuation in
            let readHandler = ReadHandlerActor()

            pipe.fileHandleForReading.setStringHandler { string in
                for line in Line.getLines(from: string) {
                    switch line {
                    case let .commandExitCode(code):
                        stream.yield(.exitCode(code))
                    case .startToken:
                        await readHandler.setStartPrint()
                    case .endToken:
                        pipe.fileHandleForReading.readabilityHandler = nil
                        continuation.resume()
                    case let .line(text) where await readHandler.canPrint():
                        stream.yield(.output(text))
                    case .endErrorToken, .line: break
                    }
                }
            }
        } onCancel: {
            pipe.fileHandleForReading.readabilityHandler = nil
        }
    }

    private func errorPipeTask(
        for pipe: Pipe,
        and stream: AsyncStream<SwiftyProcess.Output>.Continuation
    ) -> Task<Void, any Error> {
        TaskProvider.cancellableContinuationTask { continuation in
            pipe.fileHandleForReading.setStringHandler { string in
                Line.getLines(from: string).forEach { line in
                    switch line {
                    case .endErrorToken:
                        pipe.fileHandleForReading.readabilityHandler = nil
                        continuation.resume()
                    case let .line(text):
                        stream.yield(.error(text))
                    case .endToken, .startToken, .commandExitCode: break
                    }
                }
            }
        } onCancel: {
            pipe.fileHandleForReading.readabilityHandler = nil
        }
    }

    private func buildCommand(from originalCommand: String) -> String {
        let newCommand = [
            // Print start token
            "echo \"\(Separator.scriptStartToken)\"",
            // Subshell command and get exit code
            "(\(originalCommand)) || echo \"\(Separator.scriptExitCodeToken)\"",
            // Print end token
            "echo \"\(Separator.scriptEndToken)\"",
            // Print end error pipe token
            "echo \"\(Separator.scriptErrorPipeEndToken)\" >&2"
        ]

        return newCommand.joined(separator: ";")
    }

    private func configureStandardProcessAndPipe(
        command: String,
        shellType: ShellType
    ) -> (process: Process, pipe: Pipe, errorPipe: Pipe, inputPipe: Pipe) {
        let process = Process()
        let pipe = Pipe()
        let errorPipe = Pipe()
        let inputPipe = Pipe()

        process.standardOutput = pipe
        process.standardError = errorPipe
        process.launchPath = shellType.rawValue
        process.standardInput = inputPipe
        #if DEBUG
        process.arguments = ["-i", "-l", "-c", command]
        #else
        process.arguments = ["-c", command]
        #endif
        return (process, pipe, errorPipe, inputPipe)
    }

    private func moveToForeground(_ process: Process) {
        tcsetpgrp(STDIN_FILENO, process.processIdentifier)
        signal(SIGTTOU, SIG_IGN)
    }

    private func restoreDefaultForegroundProcess() {
        tcsetpgrp(STDIN_FILENO, getpid())
    }
}
