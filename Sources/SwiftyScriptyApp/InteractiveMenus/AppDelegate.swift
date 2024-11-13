import AppKit
import SwiftUI
import SwiftyScripty
import SwiftyScriptyAppViews

final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    let data: SwiftyScripty.Menu.PickerData
    var applicationDelegate: ApplicationDelegate

    init(data: SwiftyScripty.Menu.PickerData, applicationDelegate: ApplicationDelegate) {
        self.data = data
        self.applicationDelegate = applicationDelegate
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        let window = CustomWindow(
            contentRect: .zero,
            styleMask: [.closable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.contentViewController = NSHostingController(
            rootView: SinglePicker(
                title: data.title,
                options: build(from: data.data),
                delegate: self
            )
        )

        window.level = .floating
        window.titlebarAppearsTransparent = true
        window.isOpaque = false
        window.hasShadow = true

        window.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        window.collectionBehavior.insert(.fullScreenAuxiliary)
        window.center()
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()

        self.window = window
    }

    func build(from options: [SwiftyScripty.Menu.PassableData]) -> [SinglePickerOption] {
        options.map { SinglePickerOption(id: $0.id, value: $0.representation) }
    }
}

extension AppDelegate: PickerDelegate {
    func didTap(option: SinglePickerOption) {
        applicationDelegate.didSelect(
            option: .init(representation: option.value, id: option.id)
        )
    }
}
