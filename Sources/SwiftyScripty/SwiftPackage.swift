import Foundation

//sourcery: AutoMockable
public protocol SwiftPackage {
    func initialize(at path: URL)
}

struct SwiftPackageImpl: SwiftPackage {
    @Injected(\.shell) var shell: Shell

    func initialize(at path: URL) {
        let reachFolderCommand = "cd \(path.absoluteString)"
        let initializePackageCommand = "swift package init --type executable"
        shell.runZsh(command: "\(reachFolderCommand);\(initializePackageCommand)")
    }
}
