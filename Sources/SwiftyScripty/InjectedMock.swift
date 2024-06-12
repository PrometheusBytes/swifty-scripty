import Foundation

/// InjectedMock: A property wrapper for injecting mock dependencies in test environments.
///
/// This property wrapper is intended to be used only in test environments. It retrieves the value associated with the given key path from `InjectedValues`, ensuring it is a mock value suitable for testing.
@propertyWrapper
public struct InjectedMock<T, Value> {
    private let keyPath: KeyPath<InjectedValues, T>

    /// Determines if the code is running in a test environment.
    ///
    /// - Returns: `true` if the code is running in an XCTest environment, `false` otherwise.
    var isRunningTests: Bool {
        get {
            return NSClassFromString("XCTest") != nil
        }
    }

    /// The injected mock value.
    ///
    /// - Returns: The mock value for the key path if running in a test environment.
    /// - Throws: A runtime error if used outside of a test environment or if the value cannot be cast to the expected type.
    public var wrappedValue: Value {
        get {
            guard isRunningTests else {
                fatalError("@InjectedMock is meant to be used only in tests; please use @Injected during development.")
            }

            guard let value = InjectedValues[keyPath] as? Value else {
                fatalError("Trying to cast a mock of a \(InjectedValues[keyPath].self) type to \(Value.self).")
            }

            return value
        }
    }

    /// Initializes the property wrapper with the given key path.
    ///
    /// - Parameter keyPath: The key path to the value in `InjectedValues`.
    public init(_ keyPath: KeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
