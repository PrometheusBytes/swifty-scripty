import Foundation

// MARK: - Git Protocol

/// Git: A protocol defining common operations for interacting with a Git repository.
///
/// This protocol specifies methods for checking repository changes, discarding changes, and accessing the root directory of the repository.
//sourcery: AutoMockable
public protocol Git {
    /// The root directory of the Git repository.
    func getRoot() async -> String?

    /// Checks if there are any changes in the Git repository.
    ///
    /// - Returns: `true` if there are changes in the repository, `false` otherwise.
    func hasRepoChanges() async -> Bool

    /// Discards all changes in the Git repository.
    func discardChanges() async

    /// Stages all changes in the Git repository.
    func stageChanges() async

    /// Commits changes in the Git repository with the specified message.
    ///
    /// - Parameter message: The commit message.
    func commitChanges(message: String) async

    /// Pulls changes from the remote repository.
    func pull() async

    /// Pushes changes to the remote repository.
    func push() async

    /// Creates a new branch with the specified name.
    ///
    /// - Parameter branchName: The name of the new branch.
    func createBranch(branchName: String) async

    /// Switches to the specified branch.
    ///
    /// - Parameter branchName: The name of the branch to switch to.
    func switchToBranch(branchName: String) async

    /// Merges the specified branch into the current branch.
    ///
    /// - Parameter branchName: The name of the branch to merge.
    func mergeBranch(branchName: String) async

    /// Deletes the specified branch.
    ///
    /// - Parameter branchName: The name of the branch to delete.
    func deleteBranch(branchName: String) async

    /// Shows the Git log.
    func showLog() async
}

// MARK: - Git Implementation

/// GitImpl: A concrete implementation of the Git protocol.
///
/// This struct provides implementations for common Git operations using a shell command interface.
struct GitImpl: Git {
    /// The shell utility used to execute commands.
    @Injected(\.shell) var shell: Shell

    func getRoot() async -> String? {
        let commandOutput = await shell.run(command: "git rev-parse --show-toplevel")
        guard commandOutput.succeeded else { return nil }

        return commandOutput.output
    }

    func hasRepoChanges() async -> Bool {
        let gitStatus = await shell.run(command: "git status --porcelain")
        guard gitStatus.succeeded else { return false }

        return !gitStatus.output.isEmpty
    }

    func discardChanges() async {
        _ = await shell.run(command: "git checkout .")
    }
    
    func stageChanges() async {
        _ = await shell.run(command: "git add .")
    }
    
    func commitChanges(message: String) async {
        _ = await shell.run(command: "git commit -m \"\(message)\"")
    }
    
    func pull() async {
        _ = await shell.run(command: "git pull")
    }
    
    func push() async {
        _ = await shell.run(command: "git push")
    }
    
    func createBranch(branchName: String) async {
        _ = await shell.run(command: "git checkout -b \(branchName)")
    }
    
    func switchToBranch(branchName: String) async {
        _ = await shell.run(command: "git checkout \(branchName)")
    }
    
    func mergeBranch(branchName: String) async {
        _ = await shell.run(command: "git merge \(branchName)")
    }
    
    func deleteBranch(branchName: String) async {
        _ = await shell.run(command: "git branch -d \(branchName)")
    }
    
    func showLog() async {
        _ = await shell.run(command: "git log")
    }
}
