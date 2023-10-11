// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScripty
import SwiftyMocky

// MARK: - Mock Protocol

extension GitMock: ScriptMock {
    public static var id = UUID()
    public static func resetTestValue() {
        guard let mock = GitKey.value as? (any Mock) else {
            return
        }
        mock.resetMock()
    }
}
