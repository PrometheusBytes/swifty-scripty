import Foundation
import Yams

// sourcery: AutoMockable
public protocol Configuration {
    func loadFromDefault() throws -> PathConfiguration
}

public struct PathConfiguration: Codable {
    var customScripts: String
}

class ConfigurationImpl: Configuration {
    func loadFromDefault() throws -> PathConfiguration {
        let defaultConfigPath = "../configuration.yml"
        let configFileURL = URL(fileURLWithPath: defaultConfigPath)
        let yamlData = try Data(contentsOf: configFileURL)
        
        let decoder = YAMLDecoder()
        return try decoder.decode(PathConfiguration.self, from: yamlData)
    }
}
