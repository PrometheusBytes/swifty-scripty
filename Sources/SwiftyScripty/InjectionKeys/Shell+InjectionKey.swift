// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct ShellKey: InjectionKey {
    public static var value: Shell = ShellImpl()
}

extension InjectedValues {
    public var shell: Shell {
        get { return Self[ShellKey.self] }
        set { Self[ShellKey.self] = newValue }
    }
}
