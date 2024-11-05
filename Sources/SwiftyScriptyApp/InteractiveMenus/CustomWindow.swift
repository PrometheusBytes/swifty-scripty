import AppKit
import SwiftUI

class CustomWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }

    override init(contentRect: NSRect, styleMask: NSWindow.StyleMask, backing: NSWindow.BackingStoreType, defer deferValue: Bool) {
        let newStyleMask: NSWindow.StyleMask = [.borderless, .titled]
        super.init(
            contentRect: contentRect,
            styleMask: newStyleMask,
            backing: backing,
            defer: deferValue
        )

        self.isMovableByWindowBackground = true

        self.isOpaque = true
        self.backgroundColor = .clear
        self.contentView?.wantsLayer = true
        self.contentView?.layer?.cornerRadius = 10.0
        self.contentView?.layer?.masksToBounds = true
    }
}
