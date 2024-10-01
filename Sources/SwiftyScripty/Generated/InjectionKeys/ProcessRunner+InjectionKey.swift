// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all
public struct ProcessRunnerKey: InjectionKey {
    public static var liveValue: ProcessRunner { ProcessRunnerImpl() }
}

extension InjectedValues {
    public var processRunner: ProcessRunner {
        get { return Self[ProcessRunnerKey.self] }
    }
}
