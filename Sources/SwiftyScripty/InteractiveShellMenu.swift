import Foundation
import SwiftyScripty

//sourcery: AutoMockable, skipMockCreation
public protocol InteractiveShellMenu {
  func getAnswer<T: MenuOption>(
        message: String,
        given options: [T]
    ) async -> T?
}

public protocol MenuOption {
    var description: String { get }

    var clearAfter: Bool { get }
}

struct InteractiveShellMenuImpl {
    // MARK: - Properties

    @Injected(\.shell) var shell
}

extension InteractiveShellMenuImpl: InteractiveShellMenu  {
    func getAnswer<T: MenuOption>(
        message: String,
        given options: [T]
    ) async -> T? {
        guard var selection = Selection(options: options) else { return nil }

        shell.print(color: .green, text: message)
        printMenu(options: options, selected: selection.selectedIndex, clear: false)
        for try await status in InputReader.inputStream {
            switch status {
            case .arrowUp: selection.update(with: .up)
            case .arrowDown: selection.update(with: .down)
            case .arrowLeft, .arrowRight: break
            }
            shell.clear(numberOfLines: options.count)
            printMenu(options: options, selected: selection.selectedIndex)
        }

        if selection.selected.clearAfter {
            let titleLines = message.components(separatedBy: .newlines).count
            shell.clear(numberOfLines: titleLines + options.count)
        }

        return selection.selected
    }

    func printMenu(options: [MenuOption], selected: Int, clear: Bool = true) {
        for (index, option) in options.enumerated() {
            if index == selected {
                shell.print(color: .clear, text: "👉 \(option.description)")
            } else {
                shell.print(color: .clear, text: "   \(option.description)")
            }
        }
    }

    struct Selection<T: MenuOption> {
        enum Action {
            case up
            case down
        }

        let options: [T]
        var selectedIndex: Int = 0
        let lastIndex: Int
        var selected: T { options[selectedIndex] }

        init?(options: [T]) {
            guard !options.isEmpty else { return nil }

            self.options = options
            lastIndex = options.count - 1
        }

        mutating func update(with action: Action) {
            switch action {
            case .up:
                selectedIndex = (selectedIndex - 1).clamped(to: 0...lastIndex)
            case .down:
                selectedIndex = (selectedIndex + 1).clamped(to: 0...lastIndex)
            }
        }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
