// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

public struct SwiftPackageKey: InjectionKey {
    public static var value: SwiftPackage = SwiftPackageImpl()
}

extension InjectedValues {
    public var swiftPackage: SwiftPackage {
        get { return Self[SwiftPackageKey.self] }
        set { Self[SwiftPackageKey.self] = newValue }
    }
}
