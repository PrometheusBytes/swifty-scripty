@testable import SwiftyScripty
import XCTest

final class ANSIColorsTests: XCTestCase {
    func test_name_givenAllColors_thenReturnsCorrectValues() {
        // GIVEN
        let colors = ANSIColors.all()

        // WHEN
        for color in colors {
            let name = color.name()

            // THEN
            switch color {
            case .clear: XCTAssertEqual(name, "Clear")
            case .black: XCTAssertEqual(name, "Black")
            case .red: XCTAssertEqual(name, "Red")
            case .green: XCTAssertEqual(name, "Green")
            case .yellow: XCTAssertEqual(name, "Yellow")
            case .blue: XCTAssertEqual(name, "Blue")
            case .magenta: XCTAssertEqual(name, "Magenta")
            case .cyan: XCTAssertEqual(name, "Cyan")
            case .white: XCTAssertEqual(name, "White")
            }
        }
    }

    func test_debugEmoji_givenAllColors_thenReturnsCorrectValues() {
        // GIVEN
        let colors = ANSIColors.all()

        // WHEN
        for color in colors {
            let emoji = color.debugEmoji

            // THEN
            switch color {
            case .clear: XCTAssertEqual(emoji, "")
            case .black: XCTAssertEqual(emoji, "⬛️")
            case .red: XCTAssertEqual(emoji, "🟥")
            case .green: XCTAssertEqual(emoji, "🟩")
            case .yellow: XCTAssertEqual(emoji, "🟨")
            case .blue: XCTAssertEqual(emoji, "🟦")
            case .magenta: XCTAssertEqual(emoji, "🟪")
            case .cyan: XCTAssertEqual(emoji, "🟦")
            case .white: XCTAssertEqual(emoji, "⬜️")
            }
        }
    }
}
