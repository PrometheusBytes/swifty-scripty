import Foundation

// MARK: - SwiftPackage Protocol

/// A protocol for initializing Swift packages.
///
/// This protocol defines a method for initializing a Swift package at a specified path.
//sourcery: AutoMockable
public protocol SwiftPackage {
    /// Initializes a Swift package at the specified path.
    ///
    /// - Parameter path: The URL of the directory where the Swift package should be initialized.
    /// - Returns: The output of the command
    @discardableResult
    func initialize(at path: URL) async -> Command?
}

// MARK: - SwiftPackage Implementation

/// An implementation of the `SwiftPackage` protocol.
struct SwiftPackageImpl: SwiftPackage {
    /// The shell utility used to execute commands.
    @Injected(\.shell) var shell: Shell

    /// Initializes a Swift package at the specified path.
    ///
    /// - Parameter path: The URL of the directory where the Swift package should be initialized.
    /// - Returns: The output of the command
    @discardableResult
    func initialize(at path: URL) async -> Command? {
        let reachFolderCommand = "cd \(path.getFullPath())"
        let initializePackageCommand = "swift package init --type executable"
        return await shell.run(command: "\(reachFolderCommand);\(initializePackageCommand)")
    }
}
