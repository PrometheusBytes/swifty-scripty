import SwiftyScripty
import XCTest

open class ScriptTests: XCTestCase {
    open override func tearDown() {
        super.tearDown()

        InjectedValues.resetAllTests()
    }
}
