import Foundation
import SwiftyScripty
import ArgumentParser

public enum PrintType {
    case verbose
    case interactive
    case standard
}

@main
struct SwiftyScriptyCLI: AsyncParsableCommand {
    enum CodingKeys: CodingKey {
        case generate
        case setup
        case build
        case verbose
    }

    // MARK: - Arguments

    @Option(
        name: .shortAndLong,
        help: ArgumentHelp(
            "Generates new script",
            discussion: """
            
            A Command used to generate a new script
            Example:
            
            SwiftyScripty -g <ScriptName>
            
            Will generate a script with that name inside the current folder
            """,
            valueName: "Script Name"
        )
    )
    var generate: String?
    
    @Flag(name: .shortAndLong, help: "Pass the parameter to setup the script in the current folder")
    var setup: Bool = false

    @Flag(name: .shortAndLong, help: "Pass the parameter to build the script in the current folder")
    var build: Bool = false

    @Flag(name: .shortAndLong, help: "Generate verbose output")
    var verbose: Bool = false

    // MARK: - Properties

    @Injected(\.setupScript) var setupScript: SetupScript    
    @Injected(\.shell) var shell: Shell
    @Injected(\.fileUtility) var fileUtility: FileUtility
    @Injected(\.interactiveMenu) var interactiveMenu: InteractiveMenu
    @Injected(\.makeSwiftScript) var makeSwiftScript: MakeSwiftScript

    // MARK: - Run

    mutating func run() async throws {
        let currentPath = await shell.run(command: "pwd", shellType: .zsh)
        
        guard currentPath.succeeded else {
            print("ERROR: Current path not found")
            shell.exit(with: .errorExitCode)
            return
        }
        
        let url = URL(filePath: currentPath.output)

        if configuration.isInteractive {
            await runInteractiveMenu(at: url)
        } else {
            await runStandard(for: configuration, and: url)
        }
    }
}

// MARK: - Configuration

private extension SwiftyScriptyCLI {
    enum Configuration {
        case setup
        case build
        case generate(scriptName: String)
        case interactive

        var isInteractive: Bool {
            switch self {
            case .setup, .build, .generate: false
            case .interactive: true
            }
        }
    }

    var configuration: Configuration {
        if setup {
            return .setup
        } else if build {
            return .build
        } else if let scriptName = generate {
            return .generate(scriptName: scriptName)
        } else {
            return .interactive
        }
    }
}

// MARK: - Interactive Menu

extension SwiftyScriptyCLI {
    enum MenuOptions: String, CaseIterable, MenuOption {
        case buildScript = "Build Script"
        case setupScript = "Setup Script"
        case generateScript = "Generate Script"
        case help = "Help"
        case quit = "Quit"

        var clearAfter: Bool {
            switch self {
            case .buildScript, .setupScript, .generateScript: false
            case .help, .quit: true
            }
        }

        var description: String { self.rawValue }

        func explanation(tabs: Int) -> String {
            switch self {
            case .buildScript:
                """
                This command is used to create a new build executable for your script.

                By running this command, a new executable will appear inside the script folder with the same name as
                the script. You can then simply run the executable this way
                ./<your_script_name>
                to run your script

                ⚠️  This command must be ran inside the script folder.

                """.addTabs(tabs: tabs)
            case .setupScript:
                """
                This command is used to setup the script on the current folder.

                This command will read the configuration file inside the script folder, called .swiftyScriptyConfig.yml
                and will generate the injection keys and mocks needed to run the script
                This command must be executed everytime a new mockable protocol is created or edited, to allow the
                script to inject it.

                If there are no mockable protocols in your script, there is no need to run this command

                ⚠️  This command must be ran inside the script folder.

                """.addTabs(tabs: tabs)
            case .generateScript:
                """
                This command is used to generate a new script inside the current folder.

                This command will ask for the new script name and then generate a new folder for it inside the current one.
                The newly created script will already have a Package.swift file used to edit the project and the
                build generated. This script will simply print "Hello World" when ran.

                ⚠️  This command will create a new folder, but if one already exists, will ask if you want to delete it first.

                """.addTabs(tabs: tabs)
            case .help:
                """
                This command prints the help for all the menu options.

                """.addTabs(tabs: tabs)
            case .quit:
                """
                This command will close the CLI.

                """.addTabs(tabs: tabs)
            }
        }
    }

    enum YesNoOptions: MenuOption, CaseIterable {
        case yes
        case no

        var description: String {
            switch self {
            case .yes: "Yes"
            case .no: "No"
            }
        }

        var clearAfter: Bool { true }
    }

    func runInteractiveMenu(at url: URL) async {
        let welcomeMessage = """
        Welcome to Swifty Scripty! This menu will guide you to create your script.
        What would you like to do?
        """

        guard let answer = await interactiveMenu.getAnswer(
            message: welcomeMessage,
            given: MenuOptions.allCases
        ) as? MenuOptions else { return }

        shell.print(color: .green, text: "")
        switch answer {
        case .buildScript: runBuildScript(at: url, printType: .interactive)
        case .setupScript: runSetupScript(at: url, print: .interactive)
        case .generateScript: await runMakeScript(at: url)
        case .help:
            if await printHelp() {
                await runInteractiveMenu(at: url)
            }
        case .quit: return
        }
    }

    func runMakeScript(at path: URL) async {
        guard let scriptName = shell.askQuestion(question: "Insert Script Name") else { return }

        await runMakeScript(name: scriptName, at: path, printType: .interactive)
    }

    func printHelp() async -> Bool {
        MenuOptions.allCases.forEach { menuCase in
            shell.print(color: .green, text: "▶ \(menuCase.description)\n")
            shell.print(color: .clear, text: "\(menuCase.explanation(tabs: 1))")
        }

        guard let answer = await interactiveMenu.getAnswer(
            message: "Would you like to pick another option?",
            given: YesNoOptions.allCases
        ) as? YesNoOptions else {
            return false
        }

        return answer == .yes
    }
}

// MARK: - Standard Functions

private extension SwiftyScriptyCLI {
    func runStandard(for configuration: Configuration, and url: URL) async {
        switch configuration {
        case .setup:
            runSetupScript(at: url, print: verbose ? .verbose : .standard)
        case .build:
            runBuildScript(at: url, printType: verbose ? .verbose : .standard)
        case let .generate(scriptName):
            await runMakeScript(name: scriptName, at: url, printType: verbose ? .verbose : .standard)
        case .interactive: break
        }
    }

    func runSetupScript(at path: URL, print: PrintType) {
        do {
            try setupScript.setup(at: path, print: print)
        } catch {
            shell.print(color: .red, text: "ERROR: \(error.localizedDescription)")
            shell.exit(with: .errorExitCode)
        }
    }

    func runBuildScript(at path: URL, printType: PrintType) {
        do {
            try setupScript.build(at: path, print: printType)
        } catch  {
            shell.print(color: .red, text: "ERROR: \(error.localizedDescription)")
            shell.exit(with: .errorExitCode)
        }
    }

    func runMakeScript(name: String, at path: URL, printType: PrintType) async {
        do {
            try await makeSwiftScript.createScript(with: name, at: path, print: printType)
        } catch {
            fileUtility.deleteFile(at: path.appending(path: name))
            shell.print(color: .red, text: "ERROR: \(error.localizedDescription)")
            shell.exit(with: .errorExitCode)
        }
    }
}

fileprivate extension String {
    func addTabs(tabs: Int) -> String {
        let tabString = String(repeating: "\t", count: tabs)
        return self.components(separatedBy: .newlines).map { "\(tabString)\($0)" }.joined(separator: "\n")
    }
}
