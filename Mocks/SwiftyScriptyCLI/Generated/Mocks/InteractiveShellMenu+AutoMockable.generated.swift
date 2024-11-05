// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScriptyCLI

public class InteractiveShellMenuMock: InteractiveShellMenu {

    public init() {}

    //MARK: - getAnswer

    public var getAnswerMessageGivenCallsCount = 0
    public var getAnswerMessageGivenCalled: Bool {
        return getAnswerMessageGivenCallsCount > 0
    }
    public var getAnswerMessageGivenReceivedArguments: (message: String, options: [MenuOption])?
    public var getAnswerMessageGivenReceivedInvocations: [(message: String, options: [MenuOption])] = []
    public var getAnswerMessageGivenReturnValue: MenuOption?
    public var getAnswerMessageGivenClosure: ((String, [MenuOption]) -> MenuOption?)?

    public func getAnswer(message: String, given options: [MenuOption]) -> MenuOption? {
        getAnswerMessageGivenCallsCount += 1
        getAnswerMessageGivenReceivedArguments = (message: message, options: options)
        getAnswerMessageGivenReceivedInvocations.append((message: message, options: options))
        return getAnswerMessageGivenClosure.map({ $0(message, options) }) ?? getAnswerMessageGivenReturnValue
    }

}
