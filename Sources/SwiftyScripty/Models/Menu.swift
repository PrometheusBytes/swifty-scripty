import Foundation

public enum SwiftyScripty {
    public enum Menu {}
}

public extension SwiftyScripty.Menu {
    struct PassableData: Codable, Identifiable {
        public let representation: String
        public let id: Int

        public init(representation: String, id: Int) {
            self.representation = representation
            self.id = id
        }
    }
}

public extension SwiftyScripty.Menu {
    struct PickerData: Codable {
        public let title: String
        public let data: [PassableData]
    }
}
