// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScripty
import SwiftyMocky

// MARK: - Mock Protocol

extension ConfigurationMock: ScriptMock {
    public static var id = UUID()
    public static func resetTestValue() {
        guard let mock = ConfigurationKey.value as? (any Mock) else {
            return
        }
        mock.resetMock()
    }
}
