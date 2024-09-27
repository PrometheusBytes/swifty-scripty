@testable import SwiftyScripty
import SwiftyScriptyMocks
import XCTest

final class SwiftPackageTests: XCTestCase {
    // MARK: - Constants

    enum Constants {
        static let path = URL(string: "./tmp/config")!
    }

    // MARK: - Properties

    var sut: SwiftPackageImpl!
    @InjectedMock(\.shell) var shellDependency: SwiftyScriptyMocks.ShellMock

    // MARK: - SetUp

    override func setUp() {
        super.setUp()
        sut = SwiftPackageImpl()
    }

    // MARK: - Tests

    func test_initialize_thenCallsCorrectCommand() async {
        // GIVEN
        let reachCommand = "cd \(Constants.path.getFullPath())"
        let initializeCommand = "swift package init --type executable"

        // WHEN
        await sut.initialize(at: Constants.path)

        // THEN
        XCTAssertTrue(shellDependency.runCommandShellTypeCalled)
        XCTAssertEqual(
            shellDependency.runCommandShellTypeReceivedArguments?.command,
            "\(reachCommand);\(initializeCommand)"
        )
        XCTAssertEqual(
            shellDependency.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }
}
