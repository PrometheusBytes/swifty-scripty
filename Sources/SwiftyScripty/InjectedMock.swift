import Foundation

@propertyWrapper
public struct InjectedMock<T, Value> {
    private let keyPath: KeyPath<InjectedValues, T>
    var isRunningTests: Bool {
        get {
            return NSClassFromString("XCTest") != nil
        }
    }

    public var wrappedValue: Value {
        get {
            guard isRunningTests else {
                fatalError("@InjectedMock is meant to be used only on tests, please use @Inject")
            }

            guard let value = InjectedValues[keyPath] as? Value else {
                    fatalError("Trying to cast a mock of a \(InjectedValues[keyPath].self) type to \(Value.self)")
            }
    
            return value
        }
    }

    public init(_ keyPath: KeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
