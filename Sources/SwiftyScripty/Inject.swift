import Foundation

/// InjectedValues: A simple struct for managing dependency injection values.
///
/// This struct allows for the retrieval of dependencies using subscript syntax. It provides support for live and test environments by checking if the code is running within an XCTest environment.
public struct InjectedValues {
    private static var current = InjectedValues()

    /// Retrieves the value associated with the given injection key type.
    ///
    /// If the code is running in a test environment, it returns the test value; otherwise, it returns the live value.
    ///
    /// - Parameter key: The injection key type.
    /// - Returns: The value associated with the given key.
    public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get {
            if isRunningTests {
                return key.testValue
            } else {
                return key.liveValue
            }
        }
    }

    /// Retrieves the value associated with the given key path.
    ///
    /// - Parameter keyPath: The key path to the value in `InjectedValues`.
    /// - Returns: The value at the specified key path.
    public static subscript<T>(_ keyPath: KeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
    }

    /// Determines if the code is running in a test environment.
    ///
    /// - Returns: `true` if the code is running in an XCTest environment, `false` otherwise.
    static var isRunningTests: Bool {
        get {
            return NSClassFromString("XCTest") != nil
        }
    }
}

/// InjectionKey: A protocol for defining keys used in dependency injection.
///
/// This protocol requires conforming types to provide a live value and a test value for the associated type.
public protocol InjectionKey: Hashable {
    associatedtype Value

    /// The live value for the key.
    static var liveValue: Self.Value { get }
    
    /// The test value for the key.
    static var testValue: Self.Value { get }
}

/// Injected: A property wrapper for injecting dependencies.
///
/// This property wrapper retrieves the value associated with the given key path from `InjectedValues`.
@propertyWrapper
public struct Injected<T> {
    private let keyPath: KeyPath<InjectedValues, T>

    /// The injected value.
    public var wrappedValue: T {
        get { InjectedValues[keyPath] }
    }

    /// Initializes the property wrapper with the given key path.
    ///
    /// - Parameter keyPath: The key path to the value in `InjectedValues`.
    public init(_ keyPath: KeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
