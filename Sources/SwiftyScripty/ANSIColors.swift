/// ANSIColors: An enumeration of ANSI color codes for terminal text coloring.
///
/// This enum provides a set of ANSI color codes as raw string values to be used for coloring text output in a terminal.
/// It also provides utility functions to get the name of the color and a debug emoji representation of the color.
public enum ANSIColors: String {
    /// Clears any previous color formatting.
    case clear = "\u{001B}[0m"
    
    /// Black color code.
    case black = "\u{001B}[0;30m"
    
    /// Red color code.
    case red = "\u{001B}[0;31m"
    
    /// Green color code.
    case green = "\u{001B}[0;32m"
    
    /// Yellow color code.
    case yellow = "\u{001B}[0;33m"
    
    /// Blue color code.
    case blue = "\u{001B}[0;34m"
    
    /// Magenta color code.
    case magenta = "\u{001B}[0;35m"
    
    /// Cyan color code.
    case cyan = "\u{001B}[0;36m"
    
    /// White color code.
    case white = "\u{001B}[0;37m"

    /// Returns the name of the color as a string.
    ///
    /// - Returns: A `String` representing the name of the color.
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

    /// A debug emoji representation of the color.
    ///
    /// - Returns: A `String` containing an emoji that represents the color.
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

    /// Returns an array of all the ANSIColors cases.
    ///
    /// - Returns: An array of `ANSIColors` containing all the color cases.
    static func all() -> [ANSIColors] {
        return [.clear, .black, .red, .green, .yellow, .blue, .magenta, .cyan, .white]
    }
}
