// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScripty

public class InteractiveMenuMock: InteractiveMenu {

    public init() {}

    //MARK: - showMenu

    public var showMenuForTitleCallsCount = 0
    public var showMenuForTitleCalled: Bool {
        return showMenuForTitleCallsCount > 0
    }
    public var showMenuForTitleReceivedArguments: (options: [String], title: String)?
    public var showMenuForTitleReceivedInvocations: [(options: [String], title: String)] = []
    public var showMenuForTitleReturnValue: String?
    public var showMenuForTitleClosure: (([String], String) -> String?)?

    public func showMenu(for options: [String], title: String) -> String? {
        showMenuForTitleCallsCount += 1
        showMenuForTitleReceivedArguments = (options: options, title: title)
        showMenuForTitleReceivedInvocations.append((options: options, title: title))
        return showMenuForTitleClosure.map({ $0(options, title) }) ?? showMenuForTitleReturnValue
    }

}
