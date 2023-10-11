import Foundation
import SwiftyScripty

public protocol Registrator {
    static func registerMock<V>(object: V)
}

public struct DefaultRegistrator: Registrator {
    public static func registerMock<V>(object: V) {
        switch object {
        // sourcery:inline:DefaultRegistrator.InlineRegistrator
        case is Configuration:
            let mock = ConfigurationMock()
            InjectedValues[ConfigurationKey.self] = mock
            InjectedValues.addResetFunction(ConfigurationMock.resetTestValue, for: ConfigurationMock.id)

        case is Git:
            let mock = GitMock()
            InjectedValues[GitKey.self] = mock
            InjectedValues.addResetFunction(GitMock.resetTestValue, for: GitMock.id)

        case is Repository:
            let mock = RepositoryMock()
            InjectedValues[RepositoryKey.self] = mock
            InjectedValues.addResetFunction(RepositoryMock.resetTestValue, for: RepositoryMock.id)

        case is Shell:
            let mock = ShellMock()
            InjectedValues[ShellKey.self] = mock
            InjectedValues.addResetFunction(ShellMock.resetTestValue, for: ShellMock.id)

        case is SourceryWrapper:
            let mock = SourceryWrapperMock()
            InjectedValues[SourceryWrapperKey.self] = mock
            InjectedValues.addResetFunction(SourceryWrapperMock.resetTestValue, for: SourceryWrapperMock.id)

        case is SwiftPackage:
            let mock = SwiftPackageMock()
            InjectedValues[SwiftPackageKey.self] = mock
            InjectedValues.addResetFunction(SwiftPackageMock.resetTestValue, for: SwiftPackageMock.id)
        // sourcery:end
  
        default:
            return
        }
    }
}
