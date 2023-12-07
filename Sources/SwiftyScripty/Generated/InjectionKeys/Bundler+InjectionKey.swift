// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct BundlerKey: InjectionKey {
    public static var liveValue: Bundler { BundlerImpl() }
    public static var testValue: Bundler { _test }
    private static var _test = BundlerMock()
}

extension InjectedValues {
    public var bundler: Bundler {
        get { return Self[BundlerKey.self] }
    }
}
