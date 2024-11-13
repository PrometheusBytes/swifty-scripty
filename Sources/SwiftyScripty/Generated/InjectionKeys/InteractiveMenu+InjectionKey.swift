// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all
public struct InteractiveMenuKey: InjectionKey {
    public static var liveValue: InteractiveMenu { InteractiveMenuImpl() }
}

extension InjectedValues {
    public var interactiveMenu: InteractiveMenu {
        get { return Self[InteractiveMenuKey.self] }
    }
}
