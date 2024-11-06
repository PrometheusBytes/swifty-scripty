@testable import SwiftyScripty
import SwiftyScriptyMocks
import XCTest

final class InteractiveMenuTests: XCTestCase {
    // MARK: - Properties

    var underTest: InteractiveMenu!
    @InjectedMock(\.processRunner) var processRunner: ProcessRunnerMock

    // MARK: - SetUp

    override func setUp() {
        super.setUp()

        underTest = InteractiveMenuImpl()
    }

    // MARK: - Tests

    func test_showMenu_givenFailure_thenReturnsNil() async {
        // GIVEN
        mockProcessRunner(for: [.error(.errorString)])

        // WHEN
        let answer = await underTest.showMenu(for: .options, title: .title)

        // THEN
        XCTAssertNil(answer)
    }

    func test_showMenu_givenOtherString_thenReturnsNil() async {
        // GIVEN
        mockProcessRunner(for: [.output(.text)])

        // WHEN
        let answer = await underTest.showMenu(for: .options, title: .title)

        // THEN
        XCTAssertNil(answer)
    }

    func test_showMenu_givenChoice_thenReturnsChoice() async throws {
        // GIVEN
        let option = SwiftyScripty.Menu.PassableData(representation: .option1, id: 1)
        let optionData = try JSONEncoder().encode(option)
        let optionString = String(data: optionData, encoding: .utf8)
        mockProcessRunner(for: [.output(optionString!)])

        // WHEN
        let answer = await underTest.showMenu(for: .options, title: .title)

        // THEN
        XCTAssertEqual(option.representation, answer)
    }
}

// MARK: - Helpers

private extension InteractiveMenuTests {
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

fileprivate extension Array<String> {
    static let options: Self = [.option1, .option2]
}

fileprivate extension String {
    static let errorString = "Error"
    static let option1 = "Option 1"
    static let option2 = "Option 2"
    static let title = "Title"
    static let text = "Some Text"
}
