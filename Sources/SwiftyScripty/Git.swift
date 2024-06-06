import Foundation

// MARK: - Git Protocol

/// Git: A protocol defining common operations for interacting with a Git repository.
///
/// This protocol specifies methods for checking repository changes, discarding changes, and accessing the root directory of the repository.
//sourcery: AutoMockable
public protocol Git {
    /// The root directory of the Git repository.
    var root: String? { get }
    
    /// Checks if there are any changes in the Git repository.
    ///
    /// - Returns: `true` if there are changes in the repository, `false` otherwise.
    func hasRepoChanges() -> Bool
    
    /// Discards all changes in the Git repository.
    func discardChanges()
    
    /// Stages all changes in the Git repository.
    func stageChanges()
    
    /// Commits changes in the Git repository with the specified message.
    ///
    /// - Parameter message: The commit message.
    func commitChanges(message: String)
    
    /// Pulls changes from the remote repository.
    func pull()
    
    /// Pushes changes to the remote repository.
    func push()
    
    /// Creates a new branch with the specified name.
    ///
    /// - Parameter branchName: The name of the new branch.
    func createBranch(branchName: String)
    
    /// Switches to the specified branch.
    ///
    /// - Parameter branchName: The name of the branch to switch to.
    func switchToBranch(branchName: String)
    
    /// Merges the specified branch into the current branch.
    ///
    /// - Parameter branchName: The name of the branch to merge.
    func mergeBranch(branchName: String)
    
    /// Deletes the specified branch.
    ///
    /// - Parameter branchName: The name of the branch to delete.
    func deleteBranch(branchName: String)
    
    /// Shows the Git log.
    func showLog()
}

// MARK: - Git Implementation

/// GitImpl: A concrete implementation of the Git protocol.
///
/// This struct provides implementations for common Git operations using a shell command interface.
struct GitImpl: Git {
    /// The shell utility used to execute commands.
    @Injected(\.shell) var shell: Shell

    var root: String? {
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
    
    func stageChanges() {
        shell.runZsh(command: "git add .")
    }
    
    func commitChanges(message: String) {
        shell.runZsh(command: "git commit -m \"\(message)\"")
    }
    
    func pull() {
        shell.runZsh(command: "git pull")
    }
    
    func push() {
        shell.runZsh(command: "git push")
    }
    
    func createBranch(branchName: String) {
        shell.runZsh(command: "git checkout -b \(branchName)")
    }
    
    func switchToBranch(branchName: String) {
        shell.runZsh(command: "git checkout \(branchName)")
    }
    
    func mergeBranch(branchName: String) {
        shell.runZsh(command: "git merge \(branchName)")
    }
    
    func deleteBranch(branchName: String) {
        shell.runZsh(command: "git branch -d \(branchName)")
    }
    
    func showLog() {
        shell.runZsh(command: "git log")
    }
}
