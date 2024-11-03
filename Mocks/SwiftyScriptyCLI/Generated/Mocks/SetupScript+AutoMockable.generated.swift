// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScriptyCLI

public class SetupScriptMock: SetupScript {

    public init() {}

    //MARK: - setup

    public var setupAtPrintThrowableError: Error?
    public var setupAtPrintCallsCount = 0
    public var setupAtPrintCalled: Bool {
        return setupAtPrintCallsCount > 0
    }
    public var setupAtPrintReceivedArguments: (path: URL, print: PrintType)?
    public var setupAtPrintReceivedInvocations: [(path: URL, print: PrintType)] = []
    public var setupAtPrintClosure: ((URL, PrintType) throws -> Void)?

    public func setup(at path: URL, print: PrintType) throws {
        if let error = setupAtPrintThrowableError {
            throw error
        }
        setupAtPrintCallsCount += 1
        setupAtPrintReceivedArguments = (path: path, print: print)
        setupAtPrintReceivedInvocations.append((path: path, print: print))
        try setupAtPrintClosure?(path, print)
    }

    //MARK: - build

    public var buildAtWithPrintThrowableError: Error?
    public var buildAtWithPrintCallsCount = 0
    public var buildAtWithPrintCalled: Bool {
        return buildAtWithPrintCallsCount > 0
    }
    public var buildAtWithPrintReceivedArguments: (path: URL, configuration: SetupScriptModels.Scripts?, print: PrintType)?
    public var buildAtWithPrintReceivedInvocations: [(path: URL, configuration: SetupScriptModels.Scripts?, print: PrintType)] = []
    public var buildAtWithPrintClosure: ((URL, SetupScriptModels.Scripts?, PrintType) throws -> Void)?

    public func build(at path: URL, with configuration: SetupScriptModels.Scripts?, print: PrintType) throws {
        if let error = buildAtWithPrintThrowableError {
            throw error
        }
        buildAtWithPrintCallsCount += 1
        buildAtWithPrintReceivedArguments = (path: path, configuration: configuration, print: print)
        buildAtWithPrintReceivedInvocations.append((path: path, configuration: configuration, print: print))
        try buildAtWithPrintClosure?(path, configuration, print)
    }

}
