@testable import SwiftyScripty
import XCTest

final class BundlerTests: XCTestCase {
  var sut: BundlerImpl!
  @InjectedMock(\.shell) var shellDependency: ShellMock

  override func setUp() {
    super.setUp()
    sut = BundlerImpl()
  }

  func test_isInstalled_givenNoMinimumVersion_andShellError_thenReturnsFalse() {
    // GIVEN
    shellDependency.zshCommandReturnValue = nil

    // WHEN
    let isInstalled = sut.isInstalled()

    // THEN
    XCTAssertFalse(isInstalled)
  }

  func test_isInstalled_givenNoMinimumVersion_andBundlerNotInstalled_thenReturnsFalse() {
    // GIVEN
    shellDependency.zshCommandReturnValue = "Bundler not installed"

    // WHEN
    let isInstalled = sut.isInstalled()

    // THEN
    XCTAssertFalse(isInstalled)
  }

  func test_isInstalled_givenNoMinimumVersion_andBundlerInstalled_thenReturnsTrue() {
    // GIVEN
    shellDependency.zshCommandReturnValue = "Bundler version 1"

    // WHEN
    let isInstalled = sut.isInstalled()

    // THEN
    XCTAssertTrue(isInstalled)
  }

  func test_isInstalled_givenMinimumVersion_andBundlerWithOlderVersion_thenReturnsFalse() {
    // GIVEN
    shellDependency.zshCommandReturnValue = "Bundler version 2.0.1"

    // WHEN
    let isInstalled = sut.isInstalled(minimumVersion: Version(2, 1))

    // THEN
    XCTAssertFalse(isInstalled)
    let printed = shellDependency.printColorTextReceivedArguments?.text
    XCTAssertEqual(printed, "Bundler version installed is 2.0.1")
  }
}
