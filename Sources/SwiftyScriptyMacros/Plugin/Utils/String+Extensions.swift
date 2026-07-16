import Foundation

extension String {
    var lowerFirstWord: String {
        guard !isEmpty else { return self }
        let chars = Array(self)

        var upperCount = 0
        while upperCount < chars.count && chars[upperCount].isUppercase {
            upperCount += 1
        }
        
        if upperCount <= 1 { return prefix(1).lowercased() + dropFirst() }

        if upperCount == chars.count { return lowercased() }

        return String(chars[0..<(upperCount - 1)]).lowercased() + String(chars[(upperCount - 1)...])
    }
}
