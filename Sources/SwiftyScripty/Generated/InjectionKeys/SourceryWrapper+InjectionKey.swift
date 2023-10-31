// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct SourceryWrapperKey: InjectionKey {
    public static var liveValue: SourceryWrapper { SourceryWrapperImpl() }
    public static var testValue: SourceryWrapper { _test }
    private static var _test = SourceryWrapperMock()
}

extension InjectedValues {
    public var sourceryWrapper: SourceryWrapper {
        get { return Self[SourceryWrapperKey.self] }
    }
}