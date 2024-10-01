// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all
import SwiftyScripty

public struct MakeSwiftScriptKey: InjectionKey {
    public static var liveValue: MakeSwiftScript { MakeSwiftScriptImpl() }
}

extension InjectedValues {
    public var makeSwiftScript: MakeSwiftScript {
        get { return Self[MakeSwiftScriptKey.self] }
    }
}
