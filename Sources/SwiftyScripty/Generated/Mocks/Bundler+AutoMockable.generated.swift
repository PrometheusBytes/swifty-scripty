// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

public class BundlerMock: Bundler {


    public init() {}

    //MARK: - isInstalled

    public var isInstalledMinimumVersionCallsCount = 0
    public var isInstalledMinimumVersionCalled: Bool {
        return isInstalledMinimumVersionCallsCount > 0
    }
    public var isInstalledMinimumVersionReceivedMinimumVersion: Version?
    public var isInstalledMinimumVersionReceivedInvocations: [Version] = []
    public var isInstalledMinimumVersionReturnValue: Bool!
    public var isInstalledMinimumVersionClosure: ((Version) -> Bool)?

    public func isInstalled(minimumVersion: Version) -> Bool {
        isInstalledMinimumVersionCallsCount += 1
        isInstalledMinimumVersionReceivedMinimumVersion = minimumVersion
        isInstalledMinimumVersionReceivedInvocations.append(minimumVersion)
        return isInstalledMinimumVersionClosure.map({ $0(minimumVersion) }) ?? isInstalledMinimumVersionReturnValue
    }

    //MARK: - isInstalled

    public var isInstalledCallsCount = 0
    public var isInstalledCalled: Bool {
        return isInstalledCallsCount > 0
    }
    public var isInstalledReturnValue: Bool!
    public var isInstalledClosure: (() -> Bool)?

    public func isInstalled() -> Bool {
        isInstalledCallsCount += 1
        return isInstalledClosure.map({ $0() }) ?? isInstalledReturnValue
    }

    //MARK: - installGems

    public var installGemsCallsCount = 0
    public var installGemsCalled: Bool {
        return installGemsCallsCount > 0
    }
    public var installGemsReturnValue: Bool!
    public var installGemsClosure: (() -> Bool)?

    public func installGems() -> Bool {
        installGemsCallsCount += 1
        return installGemsClosure.map({ $0() }) ?? installGemsReturnValue
    }

    //MARK: - updateGems

    public var updateGemsCallsCount = 0
    public var updateGemsCalled: Bool {
        return updateGemsCallsCount > 0
    }
    public var updateGemsReturnValue: Bool!
    public var updateGemsClosure: (() -> Bool)?

    public func updateGems() -> Bool {
        updateGemsCallsCount += 1
        return updateGemsClosure.map({ $0() }) ?? updateGemsReturnValue
    }

    //MARK: - executeBundlerCommand

    public var executeBundlerCommandArgumentsCallsCount = 0
    public var executeBundlerCommandArgumentsCalled: Bool {
        return executeBundlerCommandArgumentsCallsCount > 0
    }
    public var executeBundlerCommandArgumentsReceivedArguments: (command: String, arguments: [String])?
    public var executeBundlerCommandArgumentsReceivedInvocations: [(command: String, arguments: [String])] = []
    public var executeBundlerCommandArgumentsReturnValue: String?
    public var executeBundlerCommandArgumentsClosure: ((String, [String]) -> String?)?

    public func executeBundlerCommand(_ command: String, arguments: [String]) -> String? {
        executeBundlerCommandArgumentsCallsCount += 1
        executeBundlerCommandArgumentsReceivedArguments = (command: command, arguments: arguments)
        executeBundlerCommandArgumentsReceivedInvocations.append((command: command, arguments: arguments))
        return executeBundlerCommandArgumentsClosure.map({ $0(command, arguments) }) ?? executeBundlerCommandArgumentsReturnValue
    }

}
