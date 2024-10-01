import Foundation

/// A `struct` representing a system process.
public struct SwiftyProcess {

    // MARK: - Private Properties

    private let process: Process
    private let inputPipe: Pipe

    // MARK: - Public Properties

    /// The `AsyncStream` that posts the output of the command while it's executing.
    public let stream: AsyncStream<Output>

    // MARK: - Init

    init(stream: AsyncStream<Output>, process: Process, inputPipe: Pipe) {
        self.stream = stream
        self.process = process
        self.inputPipe = inputPipe
    }

    // MARK: - Public Functions

    /// Writes new data to the standard input pipe, allowing the process to read it.
    ///
    /// - Parameters:
    ///   - data: The `Data` to be written in the pipe.
    ///   - terminateOnFailure: Optional, if `true`, terminates the process if the write fails for any reason.
    public func write(
        data: Data,
        terminateOnFailure: Bool = false
    ) {
        do {
            try writeData(data, in: inputPipe)
        } catch {
            if terminateOnFailure {
                process.terminate()
            }
        }
    }

    /// Writes new data to the standard input pipe, allowing the process to read it.
    ///
    /// - Parameters:
    ///   - string: The `String` to be written in the pipe, using the `utf8` encoding.
    ///   - terminateOnFailure: Optional, if `true`, terminates the process if the write fails for any reason.
    public func write(
        string: String,
        terminateOnFailure: Bool = false
    ) {
        do {
            guard let data = string.data(using: .utf8) else { throw NSError() }

            try writeData(data, in: inputPipe)
        } catch {
            if terminateOnFailure {
                process.terminate()
            }
        }
    }

    // MARK: - Private Functions

    private func writeData(_ data: Data, in pipe: Pipe) throws {
        try pipe.fileHandleForWriting.write(contentsOf: data)
        try pipe.fileHandleForWriting.close()
    }
}

// MARK: - Output

public extension SwiftyProcess {
    /// The enum representing the output of the process.
    enum Output {
        /// Regular output on the `standardOutput` pipe.
        case output(String)
        /// Error output on the `standardError` pipe.
        case error(String)
        /// Error thrown on creating the process.
        case failureRunningProcess(Error)
        /// Termination code of the process.
        case exitCode(Int32)
    }
}
