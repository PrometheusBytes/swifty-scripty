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
        do {
            if let inputData = readDataFromStdin() {
                return try JSONDecoder().decode(SwiftyScripty.Menu.PickerData.self, from: inputData)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }

    func readDataFromStdin() -> Data? {
        let handle = FileHandle.standardInput
        guard let data =  try? handle.readToEnd() else {
            return nil
        }

        return data
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
