import Foundation

/// Protocol defining operations related to Bundler.
// sourcery: AutoMockable
public protocol Bundler {
    /// Checks if Bundler is installed and if its version meets the specified minimum version requirement.
    ///
    /// - Parameter minimumVersion: The minimum version required.
    /// - Returns: `true` if Bundler is installed and its version meets the minimum requirement, otherwise `false`.
    func isInstalled(minimumVersion: Version) -> Bool
    
    /// Checks if Bundler is installed without considering the version.
    ///
    /// - Returns: `true` if Bundler is installed, otherwise `false`.
    func isInstalled() -> Bool
}

/// Concrete implementation of the Bundler protocol.
struct BundlerImpl: Bundler {
    /// The shell utility used to execute commands.
    @Injected(\.shell) var shell

    func isInstalled(minimumVersion: Version) -> Bool {
        guard let currentVersion = shell.zsh(command: "bundle -v") else {
            return false
        }

        guard let bundlerVersion = Version(text: currentVersion, format: "Bundler version <version>") else {
            return false
        }

        shell.print(color: .magenta, text: "Bundler version installed is \(bundlerVersion)")
        return bundlerVersion >= minimumVersion
    }

    /// Checks if Bundler is installed without considering the version.
    ///
    /// - Returns: `true` if Bundler is installed, otherwise `false`.
    func isInstalled() -> Bool {
        return isInstalled(minimumVersion: .zero)
    }
}
