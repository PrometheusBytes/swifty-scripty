public enum ANSIColors: String {
    case clear = "\u{001B}[0m"
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"

    func name() -> String {
        switch self {
        case .clear: return "Clear"
        case .black: return "Black"
        case .red: return "Red"
        case .green: return "Green"
        case .yellow: return "Yellow"
        case .blue: return "Blue"
        case .magenta: return "Magenta"
        case .cyan: return "Cyan"
        case .white: return "White"
        }
    }

    var debugEmoji: String {
        switch self {
        case .clear:
            return ""
        case .black:
            return "⬛️"
        case .red:
            return "🟥"
        case .green:
            return "🟩"
        case .yellow:
            return "🟨"
        case .blue:
            return "🟦"
        case .magenta:
            return "🟪"
        case .cyan:
            return "🟦"
        case .white:
            return "⬜️"
        }
    }

    static func all() -> [ANSIColors] {
        return [.clear, .black, .red, .green, .yellow, .blue, .magenta, .cyan, .white]
    }
}
