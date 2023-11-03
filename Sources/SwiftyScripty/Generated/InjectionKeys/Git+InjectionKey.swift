// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct GitKey: InjectionKey {
    public static var liveValue: Git { GitImpl() }
    public static var testValue: Git { _test }
    private static var _test = GitMock()
}

extension InjectedValues {
    public var git: Git {
        get { return Self[GitKey.self] }
    }
}
