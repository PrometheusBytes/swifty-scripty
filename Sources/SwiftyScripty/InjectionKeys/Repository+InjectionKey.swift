// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct RepositoryKey: InjectionKey {
    public static var value: Repository = RepositoryImpl()
}

extension InjectedValues {
    public var repository: Repository {
        get { return Self[RepositoryKey.self] }
        set { Self[RepositoryKey.self] = newValue }
    }
}
