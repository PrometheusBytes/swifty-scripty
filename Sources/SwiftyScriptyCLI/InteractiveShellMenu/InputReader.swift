import Foundation

enum InputReader {
    enum Keystroke {
        case arrowUp
        case arrowDown
        case arrowLeft
        case arrowRight
    }

    static var inputStream: AsyncStream<Keystroke> {
        return AsyncStream { continuation in
            Task {
                let monitor = InputMonitor()
                monitor.startMonitoring(
                    onTap: { continuation.yield($0) },
                    onClose: { continuation.finish() }
                )
            }
        }
    }
}

class InputMonitor {
    private var originalTermios = termios()
    private var rawTermios = termios()
    var hasReset = false

    init() {
        // Save the original terminal settings
        tcgetattr(STDIN_FILENO, &originalTermios)
        rawTermios = originalTermios
        // Set the terminal to raw mode
        rawTermios.c_lflag &= ~(UInt(ICANON | ECHO))
        tcsetattr(STDIN_FILENO, TCSANOW, &rawTermios)
    }

    deinit {
        if !hasReset { resetTerminal() }
    }

    func resetTerminal() {
        // Restore original terminal settings
        tcsetattr(STDIN_FILENO, TCSANOW, &originalTermios)
        hasReset = true
    }

    func readChar() -> Character {
        var buffer: UInt8 = 0
        read(STDIN_FILENO, &buffer, 1)
        return Character(UnicodeScalar(buffer))
    }

    func startMonitoring(
        onTap: (InputReader.Keystroke) -> (),
        onClose: () -> ()
    ) {
        while true {
            let char = readChar()

            if char == "\u{1b}" {  // ESC character
                let second = readChar()
                if second == "[" {
                    let third = readChar()
                    switch third {
                    case "A":
                        onTap(.arrowUp)
                    case "B":
                        onTap(.arrowDown)
                    case "C":
                        onTap(.arrowLeft)
                    case "D":
                        onTap(.arrowRight)
                    default: break
                    }
                }
            } else if char == "\n" {
                resetTerminal()
                onClose()
                return
            }
        }
    }
}
