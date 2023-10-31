import Foundation

public struct InjectedValues {
    private static var current = InjectedValues()

    public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get {
            if isRunningTests {
                return key.testValue
            } else {
                return key.liveValue
            }
        }
    }

    public static subscript<T>(_ keyPath: KeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
    }

    static var isRunningTests: Bool {
        get {
            return NSClassFromString("XCTest") != nil
        }
    }
}

public protocol InjectionKey: Hashable {
    associatedtype Value

    static var liveValue: Self.Value { get }
    static var testValue: Self.Value { get }
}

@propertyWrapper
public struct Injected<T> {
    private let keyPath: KeyPath<InjectedValues, T>
    public var wrappedValue: T {
        get { InjectedValues[keyPath] }
    }

    public init(_ keyPath: KeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
