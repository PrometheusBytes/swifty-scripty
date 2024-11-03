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
            case skipBuild = "skip-build"
        }

        let scriptName: String
        let sources: String
        let injectionKeysPath: String
        let mocksPath: String
        let mockKeysPath: String
        let skipBuild: Bool

        public init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<SetupScriptModels.ScriptConfiguration.CodingKeys> = try decoder.container(keyedBy: SetupScriptModels.ScriptConfiguration.CodingKeys.self)
            self.scriptName = try container.decode(String.self, forKey: CodingKeys.scriptName)
            self.sources = try container.decode(String.self, forKey: CodingKeys.sources)
            self.injectionKeysPath = try container.decode(String.self, forKey: CodingKeys.injectionKeysPath)
            self.mocksPath = try container.decode(String.self, forKey: CodingKeys.mocksPath)
            self.mockKeysPath = try container.decode(String.self, forKey: CodingKeys.mockKeysPath)
            self.skipBuild = (try? container.decode(Bool.self, forKey: CodingKeys.skipBuild)) ?? false
        }
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
