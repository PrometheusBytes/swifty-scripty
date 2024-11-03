// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScripty

public class ProcessRunnerMock: ProcessRunner {

    public init() {}

    //MARK: - run

    public var runCommandShellTypeCallsCount = 0
    public var runCommandShellTypeCalled: Bool {
        return runCommandShellTypeCallsCount > 0
    }
    public var runCommandShellTypeReceivedArguments: (command: String, shellType: ShellType)?
    public var runCommandShellTypeReceivedInvocations: [(command: String, shellType: ShellType)] = []
    public var runCommandShellTypeReturnValue: SwiftyProcess!
    public var runCommandShellTypeClosure: ((String, ShellType) -> SwiftyProcess)?

    public func run(command: String, shellType: ShellType) -> SwiftyProcess {
        runCommandShellTypeCallsCount += 1
        runCommandShellTypeReceivedArguments = (command: command, shellType: shellType)
        runCommandShellTypeReceivedInvocations.append((command: command, shellType: shellType))
        return runCommandShellTypeClosure.map({ $0(command, shellType) }) ?? runCommandShellTypeReturnValue
    }

}
