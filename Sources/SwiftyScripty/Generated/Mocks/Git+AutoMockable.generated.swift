// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

public class GitMock: Git {


    public init() {}
    public var root: String?

    //MARK: - hasRepoChanges

    public var hasRepoChangesCallsCount = 0
    public var hasRepoChangesCalled: Bool {
        return hasRepoChangesCallsCount > 0
    }
    public var hasRepoChangesReturnValue: Bool!
    public var hasRepoChangesClosure: (() -> Bool)?

    public func hasRepoChanges() -> Bool {
        hasRepoChangesCallsCount += 1
        return hasRepoChangesClosure.map({ $0() }) ?? hasRepoChangesReturnValue
    }

    //MARK: - discardChanges

    public var discardChangesCallsCount = 0
    public var discardChangesCalled: Bool {
        return discardChangesCallsCount > 0
    }
    public var discardChangesClosure: (() -> Void)?

    public func discardChanges() {
        discardChangesCallsCount += 1
        discardChangesClosure?()
    }

}
