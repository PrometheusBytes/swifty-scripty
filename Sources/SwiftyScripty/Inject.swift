import Foundation

public struct InjectedValues {
    private static var current = InjectedValues()
    private static var resetFunctions = [UUID: ()->Void]()
    private static let lock = NSRecursiveLock()

    public static func resetAllTests() {
        resetFunctions.forEach { _, value in
            value()
        }
    }

    public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get {
            return key.value
        }
        set {
            guard lock.lock(before: Date().addingTimeInterval(1)) else {
                return
            }

            key.value = newValue
            lock.unlock()
        }
    }

    public static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }

    static var isRunningTests: Bool {
        get {
            return NSClassFromString("XCTest") != nil
        }
    }

    public static func addResetFunction(_ function: @escaping () -> Void, for id: UUID) {
        guard
            isRunningTests,
            lock.lock(before: Date().addingTimeInterval(1))
        else {
            return
        }

        resetFunctions[id] = function
        lock.unlock()
    }
}

public protocol InjectionKey: Hashable {
    associatedtype Value

    static var value: Self.Value { get set }
}

@propertyWrapper
public struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    public var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }

    public init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
