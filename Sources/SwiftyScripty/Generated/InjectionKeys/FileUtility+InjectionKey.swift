// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct FileUtilityKey: InjectionKey {
    public static var liveValue: FileUtility { FileUtilityImpl() }
    public static var testValue: FileUtility { _test }
    private static var _test = FileUtilityMock()
}

extension InjectedValues {
    public var fileUtility: FileUtility {
        get { return Self[FileUtilityKey.self] }
    }
}
