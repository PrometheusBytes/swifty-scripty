// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScripty

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

    //MARK: - stageChanges

    public var stageChangesCallsCount = 0
    public var stageChangesCalled: Bool {
        return stageChangesCallsCount > 0
    }
    public var stageChangesClosure: (() -> Void)?

    public func stageChanges() {
        stageChangesCallsCount += 1
        stageChangesClosure?()
    }

    //MARK: - commitChanges

    public var commitChangesMessageCallsCount = 0
    public var commitChangesMessageCalled: Bool {
        return commitChangesMessageCallsCount > 0
    }
    public var commitChangesMessageReceivedMessage: String?
    public var commitChangesMessageReceivedInvocations: [String] = []
    public var commitChangesMessageClosure: ((String) -> Void)?

    public func commitChanges(message: String) {
        commitChangesMessageCallsCount += 1
        commitChangesMessageReceivedMessage = message
        commitChangesMessageReceivedInvocations.append(message)
        commitChangesMessageClosure?(message)
    }

    //MARK: - pull

    public var pullCallsCount = 0
    public var pullCalled: Bool {
        return pullCallsCount > 0
    }
    public var pullClosure: (() -> Void)?

    public func pull() {
        pullCallsCount += 1
        pullClosure?()
    }

    //MARK: - push

    public var pushCallsCount = 0
    public var pushCalled: Bool {
        return pushCallsCount > 0
    }
    public var pushClosure: (() -> Void)?

    public func push() {
        pushCallsCount += 1
        pushClosure?()
    }

    //MARK: - createBranch

    public var createBranchBranchNameCallsCount = 0
    public var createBranchBranchNameCalled: Bool {
        return createBranchBranchNameCallsCount > 0
    }
    public var createBranchBranchNameReceivedBranchName: String?
    public var createBranchBranchNameReceivedInvocations: [String] = []
    public var createBranchBranchNameClosure: ((String) -> Void)?

    public func createBranch(branchName: String) {
        createBranchBranchNameCallsCount += 1
        createBranchBranchNameReceivedBranchName = branchName
        createBranchBranchNameReceivedInvocations.append(branchName)
        createBranchBranchNameClosure?(branchName)
    }

    //MARK: - switchToBranch

    public var switchToBranchBranchNameCallsCount = 0
    public var switchToBranchBranchNameCalled: Bool {
        return switchToBranchBranchNameCallsCount > 0
    }
    public var switchToBranchBranchNameReceivedBranchName: String?
    public var switchToBranchBranchNameReceivedInvocations: [String] = []
    public var switchToBranchBranchNameClosure: ((String) -> Void)?

    public func switchToBranch(branchName: String) {
        switchToBranchBranchNameCallsCount += 1
        switchToBranchBranchNameReceivedBranchName = branchName
        switchToBranchBranchNameReceivedInvocations.append(branchName)
        switchToBranchBranchNameClosure?(branchName)
    }

    //MARK: - mergeBranch

    public var mergeBranchBranchNameCallsCount = 0
    public var mergeBranchBranchNameCalled: Bool {
        return mergeBranchBranchNameCallsCount > 0
    }
    public var mergeBranchBranchNameReceivedBranchName: String?
    public var mergeBranchBranchNameReceivedInvocations: [String] = []
    public var mergeBranchBranchNameClosure: ((String) -> Void)?

    public func mergeBranch(branchName: String) {
        mergeBranchBranchNameCallsCount += 1
        mergeBranchBranchNameReceivedBranchName = branchName
        mergeBranchBranchNameReceivedInvocations.append(branchName)
        mergeBranchBranchNameClosure?(branchName)
    }

    //MARK: - deleteBranch

    public var deleteBranchBranchNameCallsCount = 0
    public var deleteBranchBranchNameCalled: Bool {
        return deleteBranchBranchNameCallsCount > 0
    }
    public var deleteBranchBranchNameReceivedBranchName: String?
    public var deleteBranchBranchNameReceivedInvocations: [String] = []
    public var deleteBranchBranchNameClosure: ((String) -> Void)?

    public func deleteBranch(branchName: String) {
        deleteBranchBranchNameCallsCount += 1
        deleteBranchBranchNameReceivedBranchName = branchName
        deleteBranchBranchNameReceivedInvocations.append(branchName)
        deleteBranchBranchNameClosure?(branchName)
    }

    //MARK: - showLog

    public var showLogCallsCount = 0
    public var showLogCalled: Bool {
        return showLogCallsCount > 0
    }
    public var showLogClosure: (() -> Void)?

    public func showLog() {
        showLogCallsCount += 1
        showLogClosure?()
    }

}
