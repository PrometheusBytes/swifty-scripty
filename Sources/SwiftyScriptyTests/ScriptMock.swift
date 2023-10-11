import Foundation

public protocol ScriptMock {
    static var id: UUID { get }
    
    static func resetTestValue()
}
