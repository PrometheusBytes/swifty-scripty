// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct ConfigurationKey: InjectionKey {
    public static var value: Configuration = ConfigurationImpl()
}

extension InjectedValues {
    public var configuration: Configuration {
        get { return Self[ConfigurationKey.self] }
        set { Self[ConfigurationKey.self] = newValue }
    }
}
