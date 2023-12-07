import Foundation

//sourcery: AutoMockable
public protocol Bundler {
  func isInstalled(minimumVersion: Version) -> Bool
  func isInstalled() -> Bool
}

struct BundlerImpl: Bundler {
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
    isInstalled(minimumVersion: .zero)
  }
}
