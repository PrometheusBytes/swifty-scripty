// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all
import SwiftyScripty

public struct SetupScriptKey: InjectionKey {
    public static var liveValue: SetupScript { SetupScriptImpl() }
}

extension InjectedValues {
    public var setupScript: SetupScript {
        get { return Self[SetupScriptKey.self] }
    }
}
