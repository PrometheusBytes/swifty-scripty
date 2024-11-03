import SwiftyScripty
import SwiftyScriptyMocks
@testable import SwiftyScriptyCLI
import SwiftyScriptyCLIMocks
import XCTest

final class SetupScriptTests: XCTestCase {
    // MARK: - Constants

    enum Constants {
       static let path = URL(string: "some/path")!
    }

    // MARK: - Properties

    var underTest: SetupScript!
    @InjectedMock(\.shell) var shellDependency: SwiftyScriptyMocks.ShellMock
    @InjectedMock(\.fileUtility) var fileUtility: SwiftyScriptyMocks.FileUtilityMock

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        underTest = SetupScriptImpl()
    }

    // MARK: - Tests

    func test_setup_readScriptConfiguration_givenNoConfiguration_thenThrowsError() async {
        // GIVEN
        fileUtility.fileExistsAtReturnValue = false

        // WHEN
        do {
            try await underTest.setup(at: Constants.path)
        } catch {
            // THEN
            XCTAssertEqual(error as? SetupScriptModels.Errors, SetupScriptModels.Errors.notAScript)
        }
    }
}
