// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all
public struct InteractiveShellMenuKey: InjectionKey {
    public static var liveValue: InteractiveShellMenu { InteractiveShellMenuImpl() }
}

extension InjectedValues {
    public var interactiveShellMenu: InteractiveShellMenu {
        get { return Self[InteractiveShellMenuKey.self] }
    }
}
