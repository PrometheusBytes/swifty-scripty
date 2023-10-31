// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct RepositoryKey: InjectionKey {
    public static var liveValue: Repository { RepositoryImpl() }
    public static var testValue: Repository { _test }
    private static var _test = RepositoryMock()
}

extension InjectedValues {
    public var repository: Repository {
        get { return Self[RepositoryKey.self] }
    }
}
