import Foundation

//sourcery: AutoMockable
public protocol Git {
    var srcRoot: String? { get }

    func hasRepoChanges() -> Bool
    func discardChanges()
}

struct GitImpl: Git {
    @Injected(\.shell)
    var shell: Shell

    var srcRoot: String? {
        shell.zsh(command: "git rev-parse --show-toplevel")
    }

    func hasRepoChanges() -> Bool {
        guard let gitStatus = shell.zsh(command: "git status --porcelain") else {
            return false
        }

        return !gitStatus.isEmpty
    }

    func discardChanges() {
        shell.runZsh(command: "git checkout .")
    }
}
