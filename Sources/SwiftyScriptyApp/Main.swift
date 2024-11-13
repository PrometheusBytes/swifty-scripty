import AppKit
import Foundation
import SwiftyScripty

@main
public struct AppMainScript {
    @Injected(\.shell) var shell: Shell

    public static func main() async {
        await AppMainScript().main(args: CommandLine.arguments)
    }

    public func main(args: [String] = []) async {
        guard let data = readInput() else {
            return
        }

        await App(data: data, delegate: self).run()
    }

    func readInput() -> SwiftyScripty.Menu.PickerData? {
        #if DEBUG
        let object = SwiftyScripty.Menu.PickerData(
            title: "Test",
            data: [
                .init(representation: "Option 1", id: 1),
                .init(representation: "Option 2", id: 2)
            ]
        )
        return object
        #else
        let handle = FileHandle.standardInput
        guard
            let rawData = try? handle.readToEnd(),
            let data = Data(base64Encoded: rawData)
        else {
            return nil
        }

        return try? JSONDecoder().decode(SwiftyScripty.Menu.PickerData.self, from: data)
        #endif
    }

    func writeDataToStdout(_ data: Data) {
        let handle = FileHandle.standardOutput
        handle.write(data)
    }
}

extension AppMainScript: ApplicationDelegate {
    func didSelect(option: SwiftyScripty.Menu.PassableData) {
        if let data = try? JSONEncoder().encode(option) {
            writeDataToStdout(data)
        }

        NSApplication.shared.terminate(self)
    }
}
