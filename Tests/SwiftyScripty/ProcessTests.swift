@testable import SwiftyScripty
import SwiftyScriptyMocks
import XCTest

final class ProcessRunnerTest: XCTestCase {

    // MARK: - Properties

    var underTest: ProcessRunner!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        underTest = ProcessRunnerImpl()
    }

    // MARK: - Tests

    func test_givenCommand_thenReturnsCorrectOutput() async throws {
        // GIVEN
        let command = "echo \"Hello World!\""
        let process = underTest.run(command: command, shellType: .zsh)
        var output = ""
        var exitCode: Int32 = 0

        // WHEN
        for await data in process.stream {
            switch data {
            case let .output(string): output.append(string)
            case let .exitCode(code): exitCode = code
            case .error, .failureRunningProcess: XCTFail("Process should succeed")
            }
        }

        // THEN
        XCTAssertEqual(output, "Hello World!")
        XCTAssertEqual(exitCode, 0)
    }

    func test_givenErroCommand_thenReturnsCorrectOutput() async throws {
        // GIVEN
        let command = #"echo "Error message" >&2; exit 12"#
        let process = underTest.run(command: command)
        var errorOutput = ""
        var exitCode: Int32 = 0

        // WHEN
        for await data in process.stream {
            switch data {
            case .output:
                XCTFail("Process should fail")
            case let .exitCode(code):
                exitCode = code
            case let .error(string):
                errorOutput = string
            case .failureRunningProcess:
                XCTFail("Process should start")
            }
        }

        // THEN
        XCTAssertEqual(errorOutput, "Error message")
        XCTAssertEqual(exitCode, 12)
    }
}
