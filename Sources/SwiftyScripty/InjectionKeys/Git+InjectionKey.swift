// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct GitKey: InjectionKey {
    public static var value: Git = GitImpl()
}

extension InjectedValues {
    public var git: Git {
        get { return Self[GitKey.self] }
        set { Self[GitKey.self] = newValue }
    }
}
