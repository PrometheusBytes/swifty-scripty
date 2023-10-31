// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct ShellKey: InjectionKey {
    public static var liveValue: Shell { ShellImpl() }
    public static var testValue: Shell { _test }
    private static var _test = ShellMock()
}

extension InjectedValues {
    public var shell: Shell {
        get { return Self[ShellKey.self] }
    }
}
