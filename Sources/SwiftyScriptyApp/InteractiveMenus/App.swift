import AppKit
import SwiftUI
import SwiftyScripty
import SwiftyScriptyAppViews

@MainActor
class App {
    let delegate: AppDelegate

    init(
        data: SwiftyScripty.Menu.PickerData,
        delegate: ApplicationDelegate
    ) {
        self.delegate = AppDelegate(
            data: data,
            applicationDelegate: delegate
        )
    }

    func run() {
        let app = NSApplication.shared
        app.delegate = delegate
        app.setActivationPolicy(.accessory)
        app.activate(ignoringOtherApps: true)
        app.run()
    }
}

protocol ApplicationDelegate {
    func didSelect(option: SwiftyScripty.Menu.PassableData)
}
