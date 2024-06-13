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
    
    func test_installGems_whenSuccessful_thenReturnsTrue() {
        // GIVEN
        shellDependency.runZshCommandReturnValue = .successExitCode
        
        // WHEN
        let isSuccess = sut.installGems()
        
        // THEN
        XCTAssertTrue(isSuccess)
    }
    
    func test_installGems_whenFailed_thenReturnsFalse() {
        // GIVEN
        shellDependency.runZshCommandReturnValue = .errorExitCode
        
        // WHEN
        let isSuccess = sut.installGems()
        
        // THEN
        XCTAssertFalse(isSuccess)
    }
    
    func test_updateGems_whenSuccessful_thenReturnsTrue() {
        // GIVEN
        shellDependency.runZshCommandReturnValue = .successExitCode
        
        // WHEN
        let isSuccess = sut.updateGems()
        
        // THEN
        XCTAssertTrue(isSuccess)
    }
    
    func test_updateGems_whenFailed_thenReturnsFalse() {
        // GIVEN
        shellDependency.runZshCommandReturnValue = .errorExitCode
        
        // WHEN
        let isSuccess = sut.updateGems()
        
        // THEN
        XCTAssertFalse(isSuccess)
    }
}
