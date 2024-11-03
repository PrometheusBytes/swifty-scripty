import Foundation

extension SetupScriptModels {
    enum Errors: LocalizedError {
        case notAScript
        case wrongConfigurationFile
        case generatingInjectionKeys
        case generatingMocks
        case generatingMockKeys
        case buildingScript

        var errorDescription: String? {
            switch self {
            case .notAScript:
                return "This folder does not contain a script"
            case .wrongConfigurationFile:
                return "Wrong configuration file"
            case .generatingInjectionKeys:
                return "Could not generate Injection Keys for script"
            case .generatingMocks:
                return "Could not generate Mocks for script"
            case .generatingMockKeys:
                return "Could not generate Keys associated to mocks"
            case .buildingScript:
                return "Could not build script"
            }
        }
    }
}
