// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

public class SwiftPackageMock: SwiftPackage {


    public init() {}

    //MARK: - initialize

    public var initializeAtCallsCount = 0
    public var initializeAtCalled: Bool {
        return initializeAtCallsCount > 0
    }
    public var initializeAtReceivedPath: URL?
    public var initializeAtReceivedInvocations: [URL] = []
    public var initializeAtClosure: ((URL) -> Void)?

    public func initialize(at path: URL) {
        initializeAtCallsCount += 1
        initializeAtReceivedPath = path
        initializeAtReceivedInvocations.append(path)
        initializeAtClosure?(path)
    }

    //MARK: - runInitialize

    public var runInitializeAtCallsCount = 0
    public var runInitializeAtCalled: Bool {
        return runInitializeAtCallsCount > 0
    }
    public var runInitializeAtReceivedPath: URL?
    public var runInitializeAtReceivedInvocations: [URL] = []
    public var runInitializeAtReturnValue: Command?
    public var runInitializeAtClosure: ((URL) -> Command?)?

    public func runInitialize(at path: URL) -> Command? {
        runInitializeAtCallsCount += 1
        runInitializeAtReceivedPath = path
        runInitializeAtReceivedInvocations.append(path)
        return runInitializeAtClosure.map({ $0(path) }) ?? runInitializeAtReturnValue
    }

}
