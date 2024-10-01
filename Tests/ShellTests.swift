@testable import SwiftyScripty
import SwiftyScriptyMocks
import XCTest

final class ShellTests: XCTestCase {

    // MARK: - Properties

    var underTest: Shell!
    @InjectedMock(\.processRunner) var processRunner: ProcessRunnerMock

    // MARK: - SetUp

    override func setUp() {
        super.setUp()

        underTest = ShellImpl()
    }

    // MARK: - Tests

    func test_run_givenSuccess_thenRunsCommand() async {
        // GIVEN
        mockProcessRunner(for: [.output(.output), .error(.errorOutput), .exitCode(0)])
        let expectedCommand = Command(output: .output, errorOutput: .errorOutput, exitCode: 0)

        // WHEN
        let command = await underTest.run(command: .command, shellType: .zsh)

        // THEN
        XCTAssertEqual(command, expectedCommand)
        XCTAssertTrue(processRunner.runCommandShellTypeCalled)
        XCTAssertEqual(
            processRunner.runCommandShellTypeReceivedArguments?.command,
            .command
        )
        XCTAssertEqual(
            processRunner.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_run_givenFailureInstantiatingProcess_thenRunsCommand() async {
        // GIVEN
        mockProcessRunner(for: [.failureRunningProcess(NSError())])
        let expectedCommand = Command(output: "", errorOutput: "", exitCode: 1)

        // WHEN
        let command = await underTest.run(command: .command, shellType: .zsh)

        // THEN
        XCTAssertEqual(command, expectedCommand)
        XCTAssertTrue(processRunner.runCommandShellTypeCalled)
        XCTAssertEqual(
            processRunner.runCommandShellTypeReceivedArguments?.command,
            .command
        )
        XCTAssertEqual(
            processRunner.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_readZshVar_thenRunsCorrectCommand() async {
        // GIVEN
        let command = "echo $" + .variableKey
        mockProcessRunner(for: [.output(.variable)])

        // WHEN
        let variable = await underTest.readZshVar(key: .variableKey)

        // THEN
        XCTAssertEqual(variable, .variable)
        XCTAssertTrue(processRunner.runCommandShellTypeCalled)
        XCTAssertEqual(
            processRunner.runCommandShellTypeReceivedArguments?.command,
            command
        )
        XCTAssertEqual(
            processRunner.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }
}

// MARK: - Helpers

extension ShellTests {
    func mockProcessRunner(for data: [SwiftyProcess.Output]) {
        let stream = AsyncStream<SwiftyProcess.Output> { continuation in
            Task {
                try? await Task.sleep(nanoseconds: 20)
                for value in data {
                    try? await Task.sleep(nanoseconds: 20)
                    continuation.yield(value)
                }
                try? await Task.sleep(nanoseconds: 200)
                continuation.finish()
            }
        }
        processRunner.runCommandShellTypeReturnValue = makeProcess(for: stream)
    }

    func makeProcess(
        for stream: AsyncStream<SwiftyProcess.Output>
    ) -> SwiftyProcess {
        SwiftyProcess(
            stream: stream,
            process: Process(),
            inputPipe: Pipe()
        )
    }
}

// MARK: - Constants

fileprivate extension String {
    static let command = "pwd"
    static let output = "Say My Name"
    static let errorOutput = "Under the moon"
    static let variableKey = "VAR_KEY"
    static let variable = "Variable"
    static let inputLine = "Can't wait"
}
