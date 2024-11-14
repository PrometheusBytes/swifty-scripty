import Foundation

extension ProcessRunnerImpl {
    /// An actor used to ensure thread safeness when reading the input pipe.
    /// The input pipe should not be read until we encounter the `scriptStartToken`
    /// so the purpose of this actor is to provide thread safe access to the `shouldStartPrint` variable that
    /// informs the pipe whether we can read the output or not.
    actor ReadHandlerActor {
        // MARK: - Properties

        private var shouldStartPrint: Bool

        // MARK: - Init

        init() { shouldStartPrint = false }

        // MARK: - Methods

        func setStartPrint() {
            shouldStartPrint = true
        }

        func canPrint() -> Bool {
            shouldStartPrint
        }
    }
}

extension ProcessRunnerImpl {
    /// An enum storing all the tokens used by a script while executing.
    enum Separator {
        static let scriptStartToken = "<--SwiftyScripty Interactive Shell Start-->"
        static let scriptExitCodeTokenStart = "<--SwiftyScripty Interactive Shell EXIT CODE: "
        static let scriptExitCodeToken = "\(scriptExitCodeTokenStart){$?}-->"
        static let scriptEndToken = "<--SwiftyScripty Interactive Shell End-->"
        static let scriptErrorPipeEndToken = "<--SwiftyScripty Interactive Shell Error End-->"
    }

    /// An enum capable of reading a series of lines from a raw output, and turn them in
    /// tokens that we can use to know which line we had read.
    enum Line {
        /// The line indicating the beginning of the script.
        case startToken

        /// A single output line of the script.
        case line(text: String)

        /// A line indicating the exit code of the script.
        case commandExitCode(code: Int32)

        /// A line indicating the end of reading, so that the read pipe can be closed.
        case endToken

        /// A line indicating the end of reading for the error pipe, so that the read error pipe can be closed.
        case endErrorToken

        // MARK: - Init

        init(from data: String) {
            if data == Separator.scriptStartToken {
                self = .startToken
            } else if data == Separator.scriptEndToken {
                self = .endToken
            } else if data.starts(with: Separator.scriptExitCodeTokenStart) {
                self = .commandExitCode(code: Self.extractCode(from: data) ?? .successExitCode)
            } else if data == Separator.scriptErrorPipeEndToken {
                self = .endErrorToken
            } else {
                self = .line(text: data)
            }
        }

        // MARK: - Helper Functions

        static func getLines(from output: String) -> [Line] {
            output.split(separator: "\n").map { Line(from: String($0)) }
        }

        static func extractCode(from token: String) -> Int32? {
            if
                let startRange = token.range(of: "{"),
                let endRange = token.range(of: "}", range: startRange.upperBound..<token.endIndex),
                let exitCode = Int32(String(token[startRange.upperBound..<endRange.lowerBound]))
            {
                return exitCode
            } else {
                return nil
            }
        }
    }
}
