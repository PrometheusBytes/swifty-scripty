import Foundation

//sourcery: AutoMockable
public protocol InteractiveMenu {
    func showMenu(for options: [String], title: String) async -> String?
}

struct InteractiveMenuImpl: InteractiveMenu {
    @Injected(\.processRunner) var processRunner: ProcessRunner

    /// The path to the Sourcery binary.
    let binaryPath = Bundle.module.path(
        forResource: "SwiftyScriptyApp",
        ofType: nil,
        inDirectory: "Resources/Binaries"
    )

    func showMenu(for options: [String], title: String) async -> String? {
        let result = await launchMenuProcess(
            for: .init(
                title: title,
                data: options.enumerated().map {.init(representation: $0.element, id: $0.offset) }
            )
        )
        return result?.representation
    }

    func launchMenuProcess(
        for objects: SwiftyScripty.Menu.PickerData
    ) async -> SwiftyScripty.Menu.PassableData? {
        guard
            let objectData = try? JSONEncoder().encode(objects),
            let binaryPath
        else {
            return nil
        }

        let process = processRunner.run(command: binaryPath, shellType: .zsh)
        process.write(string: objectData.base64EncodedString(), terminateOnFailure: true)

        for await data in process.stream {
            switch data {
            case .output(let string):
                if
                    let objectData = string.data(using: .utf8),
                    let object = try? JSONDecoder().decode(SwiftyScripty.Menu.PassableData.self, from: objectData)
                {
                    return object
                }

            case .failureRunningProcess, .exitCode, .error:
                break
            }
        }

        return nil
    }
}
