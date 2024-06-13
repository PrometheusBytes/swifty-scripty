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
    
    /// Installs gems specified in the project's Gemfile.
    ///
    /// - Returns: `true` if gems were successfully installed, otherwise `false`.
    func installGems() -> Bool
    
    /// Updates gems specified in the project's Gemfile to their latest versions.
    ///
    /// - Returns: `true` if gems were successfully updated, otherwise `false`.
    func updateGems() -> Bool
    
    /// Executes a Bundler command with the provided arguments.
    ///
    /// - Parameters:
    ///   - command: The Bundler command to execute.
    ///   - arguments: Additional arguments to pass to the command.
    /// - Returns: The output of the command execution, or `nil` if the command failed.
    func executeBundlerCommand(_ command: String, arguments: [String]) -> String?
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
    
    func isInstalled() -> Bool {
        return isInstalled(minimumVersion: .zero)
    }
    
    func installGems() -> Bool {
        shell.runZsh(command: "bundle install") == .successExitCode
    }
    
    func updateGems() -> Bool {
        shell.runZsh(command: "bundle update") == .successExitCode
    }
    
    func executeBundlerCommand(_ command: String, arguments: [String]) -> String? {
        let fullCommand = ["bundle", command] + arguments
        return shell.zsh(command: fullCommand.joined(separator: " "))
    }
}
