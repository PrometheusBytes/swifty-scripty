import Foundation
import SwiftyScripty

public enum SetupScriptModels {}

extension SetupScriptModels {
    public struct ScriptConfiguration: Codable {
        enum CodingKeys: String, CodingKey {
            case scriptName = "name"
            case sources
            case injectionKeysPath = "generated-injection-keys-path"
            case mocksPath = "generated-mocks-path"
            case mockKeysPath = "generated-mock-keys-path"
        }

        let scriptName: String
        let sources: String
        let injectionKeysPath: String
        let mocksPath: String
        let mockKeysPath: String
    }
}

extension SetupScriptModels {
    public struct Scripts: Codable {
        let scripts: [ScriptConfiguration]
    }
}

extension SetupScriptModels {
    public struct SourceryCommand {
        let sources: [URL]
        let templates: [URL]
        let output: URL
        let args: [SourceryWrapperArguments]
    }
}

extension SetupScriptModels {
    public struct PathConfiguration {
        let root: URL
        let sources: URL
        let injectionKeys: URL
        let mocks: URL
        let testKeys: URL
    }
}
