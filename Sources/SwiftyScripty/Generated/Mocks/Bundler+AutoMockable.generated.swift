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

}
