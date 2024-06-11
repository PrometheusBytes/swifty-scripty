// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

public class ShellMock: Shell {


    public init() {}

    //MARK: - bash

    public var bashCommandCallsCount = 0
    public var bashCommandCalled: Bool {
        return bashCommandCallsCount > 0
    }
    public var bashCommandReceivedCommand: String?
    public var bashCommandReceivedInvocations: [String] = []
    public var bashCommandReturnValue: String?
    public var bashCommandClosure: ((String) -> String?)?

    public func bash(command: String) -> String? {
        bashCommandCallsCount += 1
        bashCommandReceivedCommand = command
        bashCommandReceivedInvocations.append(command)
        return bashCommandClosure.map({ $0(command) }) ?? bashCommandReturnValue
    }

    //MARK: - bashWithExitCode

    public var bashWithExitCodeCommandCallsCount = 0
    public var bashWithExitCodeCommandCalled: Bool {
        return bashWithExitCodeCommandCallsCount > 0
    }
    public var bashWithExitCodeCommandReceivedCommand: String?
    public var bashWithExitCodeCommandReceivedInvocations: [String] = []
    public var bashWithExitCodeCommandReturnValue: Command?
    public var bashWithExitCodeCommandClosure: ((String) -> Command?)?

    public func bashWithExitCode(command: String) -> Command? {
        bashWithExitCodeCommandCallsCount += 1
        bashWithExitCodeCommandReceivedCommand = command
        bashWithExitCodeCommandReceivedInvocations.append(command)
        return bashWithExitCodeCommandClosure.map({ $0(command) }) ?? bashWithExitCodeCommandReturnValue
    }

    //MARK: - runBash

    public var runBashCommandCallsCount = 0
    public var runBashCommandCalled: Bool {
        return runBashCommandCallsCount > 0
    }
    public var runBashCommandReceivedCommand: String?
    public var runBashCommandReceivedInvocations: [String] = []
    public var runBashCommandReturnValue: Int32?
    public var runBashCommandClosure: ((String) -> Int32?)?

    public func runBash(command: String) -> Int32? {
        runBashCommandCallsCount += 1
        runBashCommandReceivedCommand = command
        runBashCommandReceivedInvocations.append(command)
        return runBashCommandClosure.map({ $0(command) }) ?? runBashCommandReturnValue
    }

    //MARK: - zsh

    public var zshCommandCallsCount = 0
    public var zshCommandCalled: Bool {
        return zshCommandCallsCount > 0
    }
    public var zshCommandReceivedCommand: String?
    public var zshCommandReceivedInvocations: [String] = []
    public var zshCommandReturnValue: String?
    public var zshCommandClosure: ((String) -> String?)?

    public func zsh(command: String) -> String? {
        zshCommandCallsCount += 1
        zshCommandReceivedCommand = command
        zshCommandReceivedInvocations.append(command)
        return zshCommandClosure.map({ $0(command) }) ?? zshCommandReturnValue
    }

    //MARK: - zshWithExitCode

    public var zshWithExitCodeCommandCallsCount = 0
    public var zshWithExitCodeCommandCalled: Bool {
        return zshWithExitCodeCommandCallsCount > 0
    }
    public var zshWithExitCodeCommandReceivedCommand: String?
    public var zshWithExitCodeCommandReceivedInvocations: [String] = []
    public var zshWithExitCodeCommandReturnValue: Command?
    public var zshWithExitCodeCommandClosure: ((String) -> Command?)?

    public func zshWithExitCode(command: String) -> Command? {
        zshWithExitCodeCommandCallsCount += 1
        zshWithExitCodeCommandReceivedCommand = command
        zshWithExitCodeCommandReceivedInvocations.append(command)
        return zshWithExitCodeCommandClosure.map({ $0(command) }) ?? zshWithExitCodeCommandReturnValue
    }

    //MARK: - runZsh

    public var runZshCommandCallsCount = 0
    public var runZshCommandCalled: Bool {
        return runZshCommandCallsCount > 0
    }
    public var runZshCommandReceivedCommand: String?
    public var runZshCommandReceivedInvocations: [String] = []
    public var runZshCommandReturnValue: Int32?
    public var runZshCommandClosure: ((String) -> Int32?)?

    public func runZsh(command: String) -> Int32? {
        runZshCommandCallsCount += 1
        runZshCommandReceivedCommand = command
        runZshCommandReceivedInvocations.append(command)
        return runZshCommandClosure.map({ $0(command) }) ?? runZshCommandReturnValue
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

    //MARK: - readBashVar

    public var readBashVarKeyCallsCount = 0
    public var readBashVarKeyCalled: Bool {
        return readBashVarKeyCallsCount > 0
    }
    public var readBashVarKeyReceivedKey: String?
    public var readBashVarKeyReceivedInvocations: [String] = []
    public var readBashVarKeyReturnValue: String?
    public var readBashVarKeyClosure: ((String) -> String?)?

    public func readBashVar(key: String) -> String? {
        readBashVarKeyCallsCount += 1
        readBashVarKeyReceivedKey = key
        readBashVarKeyReceivedInvocations.append(key)
        return readBashVarKeyClosure.map({ $0(key) }) ?? readBashVarKeyReturnValue
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
