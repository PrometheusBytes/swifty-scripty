import Foundation
import SwiftyScripty

@propertyWrapper
public struct InjectedMock<T, Value> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
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

            guard value is ScriptMock else {
                fatalError("Unable to cast injected value to mock, make sure to have passed the correct registrator")
            }
    
            return value
        }
    }

    public init(_ keyPath: WritableKeyPath<InjectedValues, T>, registrator: Registrator.Type? = nil) {
        self.keyPath = keyPath
        let value = InjectedValues[keyPath]
        
        if value is ScriptMock { return }
        (registrator ?? DefaultRegistrator.self).registerMock(object: value)
    }
}
