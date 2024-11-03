// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScripty

public class ShellMock: Shell {

    public init() {}

    //MARK: - run

    public var runCommandShellTypeCallsCount = 0
    public var runCommandShellTypeCalled: Bool {
        return runCommandShellTypeCallsCount > 0
    }
    public var runCommandShellTypeReceivedArguments: (command: String, shellType: ShellType)?
    public var runCommandShellTypeReceivedInvocations: [(command: String, shellType: ShellType)] = []
    public var runCommandShellTypeReturnValue: Command!
    public var runCommandShellTypeClosure: ((String, ShellType) -> Command)?

    public func run(command: String, shellType: ShellType) -> Command {
        runCommandShellTypeCallsCount += 1
        runCommandShellTypeReceivedArguments = (command: command, shellType: shellType)
        runCommandShellTypeReceivedInvocations.append((command: command, shellType: shellType))
        return runCommandShellTypeClosure.map({ $0(command, shellType) }) ?? runCommandShellTypeReturnValue
    }

    //MARK: - readZshVar

    public var readZshVarKeyCallsCount = 0
    public var readZshVarKeyCalled: Bool {
        return readZshVarKeyCallsCount > 0
    }
    public var readZshVarKeyReceivedKey: String?
    public var readZshVarKeyReceivedInvocations: [String] = []
    public var readZshVarKeyReturnValue: String?
    public var readZshVarKeyClosure: ((String) -> String?)?

    public func readZshVar(key: String) -> String? {
        readZshVarKeyCallsCount += 1
        readZshVarKeyReceivedKey = key
        readZshVarKeyReceivedInvocations.append(key)
        return readZshVarKeyClosure.map({ $0(key) }) ?? readZshVarKeyReturnValue
    }

    //MARK: - askQuestion

    public var askQuestionQuestionCallsCount = 0
    public var askQuestionQuestionCalled: Bool {
        return askQuestionQuestionCallsCount > 0
    }
    public var askQuestionQuestionReceivedQuestion: String?
    public var askQuestionQuestionReceivedInvocations: [String] = []
    public var askQuestionQuestionReturnValue: String?
    public var askQuestionQuestionClosure: ((String) -> String?)?

    public func askQuestion(question: String) -> String? {
        askQuestionQuestionCallsCount += 1
        askQuestionQuestionReceivedQuestion = question
        askQuestionQuestionReceivedInvocations.append(question)
        return askQuestionQuestionClosure.map({ $0(question) }) ?? askQuestionQuestionReturnValue
    }

    //MARK: - askPermission

    public var askPermissionQuestionCallsCount = 0
    public var askPermissionQuestionCalled: Bool {
        return askPermissionQuestionCallsCount > 0
    }
    public var askPermissionQuestionReceivedQuestion: String?
    public var askPermissionQuestionReceivedInvocations: [String] = []
    public var askPermissionQuestionReturnValue: Bool!
    public var askPermissionQuestionClosure: ((String) -> Bool)?

    public func askPermission(question: String) -> Bool {
        askPermissionQuestionCallsCount += 1
        askPermissionQuestionReceivedQuestion = question
        askPermissionQuestionReceivedInvocations.append(question)
        return askPermissionQuestionClosure.map({ $0(question) }) ?? askPermissionQuestionReturnValue
    }

    //MARK: - print

    public var printColorTextCallsCount = 0
    public var printColorTextCalled: Bool {
        return printColorTextCallsCount > 0
    }
    public var printColorTextReceivedArguments: (color: ANSIColors, text: String)?
    public var printColorTextReceivedInvocations: [(color: ANSIColors, text: String)] = []
    public var printColorTextClosure: ((ANSIColors, String) -> Void)?

    public func print(color: ANSIColors, text: String) {
        printColorTextCallsCount += 1
        printColorTextReceivedArguments = (color: color, text: text)
        printColorTextReceivedInvocations.append((color: color, text: text))
        printColorTextClosure?(color, text)
    }

    //MARK: - clear

    public var clearNumberOfLinesCallsCount = 0
    public var clearNumberOfLinesCalled: Bool {
        return clearNumberOfLinesCallsCount > 0
    }
    public var clearNumberOfLinesReceivedNumberOfLines: Int?
    public var clearNumberOfLinesReceivedInvocations: [Int] = []
    public var clearNumberOfLinesClosure: ((Int) -> Void)?

    public func clear(numberOfLines: Int) {
        clearNumberOfLinesCallsCount += 1
        clearNumberOfLinesReceivedNumberOfLines = numberOfLines
        clearNumberOfLinesReceivedInvocations.append(numberOfLines)
        clearNumberOfLinesClosure?(numberOfLines)
    }

    //MARK: - exit

    public var exitWithCallsCount = 0
    public var exitWithCalled: Bool {
        return exitWithCallsCount > 0
    }
    public var exitWithReceivedCode: Int32?
    public var exitWithReceivedInvocations: [Int32] = []
    public var exitWithClosure: ((Int32) -> Void)?

    public func exit(with code: Int32) {
        exitWithCallsCount += 1
        exitWithReceivedCode = code
        exitWithReceivedInvocations.append(code)
        exitWithClosure?(code)
    }

}
