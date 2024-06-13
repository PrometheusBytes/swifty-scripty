@testable import SwiftyScripty
import SwiftyScriptyMocks
import XCTest

final class SwiftPackageTests: XCTestCase {
    enum Constants {
        static let path = URL(string: "./tmp/config")!
    }

    var sut: SwiftPackageImpl!
    @InjectedMock(\.shell) var shellDependency: ShellMock

    override func setUp() {
        super.setUp()
        sut = SwiftPackageImpl()
    }

    func test_initialize_thenCallsCorrectCommand() {
        // GIVEN
        let reachCommand = "cd \(Constants.path.getFullPath())"
        let initializeCommand = "swift package init --type executable"

        // WHEN
        sut.initialize(at: Constants.path)

        // THEN
        XCTAssertTrue(shellDependency.runZshCommandCalled)
        XCTAssertEqual(shellDependency.runZshCommandReceivedCommand, "\(reachCommand);\(initializeCommand)")
    }

    func test_runInitialize_thenCallsCorrectCommand() {
        // GIVEN
        let reachCommand = "cd \(Constants.path.getFullPath())"
        let initializeCommand = "swift package init --type executable"

        // WHEN
        let command = sut.runInitialize(at: Constants.path)

        // THEN
        XCTAssertTrue(shellDependency.zshWithExitCodeCommandCalled)
        XCTAssertEqual(shellDependency.zshWithExitCodeCommandReceivedCommand, "\(reachCommand);\(initializeCommand)")
    }
}
