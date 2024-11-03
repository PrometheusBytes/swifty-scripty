// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScriptyCLI

public class MakeSwiftScriptMock: MakeSwiftScript {

    public init() {}

    //MARK: - createScript

    public var createScriptWithAtPrintThrowableError: Error?
    public var createScriptWithAtPrintCallsCount = 0
    public var createScriptWithAtPrintCalled: Bool {
        return createScriptWithAtPrintCallsCount > 0
    }
    public var createScriptWithAtPrintReceivedArguments: (name: String, path: URL, print: PrintType)?
    public var createScriptWithAtPrintReceivedInvocations: [(name: String, path: URL, print: PrintType)] = []
    public var createScriptWithAtPrintClosure: ((String, URL, PrintType) throws -> Void)?

    public func createScript(with name: String, at path: URL, print: PrintType) throws {
        if let error = createScriptWithAtPrintThrowableError {
            throw error
        }
        createScriptWithAtPrintCallsCount += 1
        createScriptWithAtPrintReceivedArguments = (name: name, path: path, print: print)
        createScriptWithAtPrintReceivedInvocations.append((name: name, path: path, print: print))
        try createScriptWithAtPrintClosure?(name, path, print)
    }

}
