import Foundation

/// Git: A protocol defining common operations for interacting with a Git repository.
///
/// This protocol specifies methods for checking repository changes, discarding changes, and accessing the root directory of the repository.
//sourcery: AutoMockable
public protocol Git {
    
    /// The root directory of the Git repository.
    var srcRoot: String? { get }

    /// Checks if there are any changes in the Git repository.
    ///
    /// - Returns: `true` if there are changes in the repository, `false` otherwise.
    func hasRepoChanges() -> Bool
    
    /// Discards all changes in the Git repository.
    func discardChanges()
}

/// GitImpl: A concrete implementation of the Git protocol.
///
/// This struct provides implementations for common Git operations using a shell command interface.
struct GitImpl: Git {
    @Injected(\.shell) var shell: Shell

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
