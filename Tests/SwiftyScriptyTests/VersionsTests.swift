@testable import SwiftyScripty
import XCTest

final class VersionsTests: XCTestCase {
    enum Constants {
        enum CommandVersions: String, CaseIterable {
            case version1 = "Command version 1"
            case version1_0_0 = "Command version 1.0.0"
            case version1_11_0 = "Command version 1.11.0"
            case version1_11_99 = "Command version 1.11.99"
            case version1_12_0 = "Command version 1.12.0"
            case version1_12_1 = "Command version 1.12.1"
            case version2 = "Command version 2"
            case version2_1 = "Command version 2.1"
            case version2_1_1 = "Command version 2.1.1"

            static let format = "Command version <version>"

            func correctVersion() -> Version {
                switch self {
                case .version1, .version1_0_0: return Version(1)
                case .version1_11_0: return Version(1, 11)
                case .version1_11_99: return Version(1, 11, 99)
                case .version1_12_0: return Version(1, 12)
                case .version1_12_1: return Version(1, 12, 1)
                case .version2: return Version(2)
                case .version2_1: return Version(2, 1)
                case .version2_1_1: return Version(2, 1, 1)
                }
            }
        }

        enum AppVersions: String, CaseIterable {
            case version1 = "App version currently is 1, edited 5th Jan 2023"
            case version1_0_0 = "App version is 1.0.0, edited 5th Jan 2023"
            case version1_11_0 = "App version is 1.11.0, edited 5th Jan 2023"
            case version1_11_99 = "App version is currently 1.11.99, edited 5th Jan 2023"
            case version1_12_0 = "App version is now 1.12.0, edited 8th Jan 2023"
            case version1_12_1 = "App version is 1.12.1, edited 5th Mar 2023"
            case version2 = "App version is Now 2, edited 5th Jan 2023"
            case version2_1 = "App version is currently 2.1, edited 10th Dec 2024"
            case version2_1_1 = "App version is 2.1.1"

            static let format = #"App version [a-zA-Z\ ]*<version>,?.*"#

            func correctVersion() -> Version {
                switch self {
                case .version1, .version1_0_0: return Version(1)
                case .version1_11_0: return Version(1, 11)
                case .version1_11_99: return Version(1, 11, 99)
                case .version1_12_0: return Version(1, 12)
                case .version1_12_1: return Version(1, 12, 1)
                case .version2: return Version(2)
                case .version2_1: return Version(2, 1)
                case .version2_1_1: return Version(2, 1, 1)
                }
            }
        }

        static let genericMessage = "ERROR: Some version not installed"
    }

    func test_init_givenDifferentVersions_thenShouldReturnCorrectVersion() {
        // GIVEN
        let version = Version(1, 2, 0)
        let secondVersion = Version(1, 2)
        let thirdVersion = Version(1)

        // THEN
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 0)
        XCTAssertEqual(secondVersion.major, 1)
        XCTAssertEqual(secondVersion.minor, 2)
        XCTAssertEqual(secondVersion.patch, 0)
        XCTAssertEqual(thirdVersion.major, 1)
        XCTAssertEqual(thirdVersion.minor, 0)
        XCTAssertEqual(thirdVersion.patch, 0)
    }

    func test_init_givenDifferentCaptures_thenShouldReturnCorrectVersion() {
        // GIVEN
        let firstDictionary = [
            Versions.major: 1,
            Versions.minor: 2,
            Versions.patch: 0,
        ]
        let secondDictionary = [
            Versions.major: 1,
            Versions.minor: 2,
        ]
        let thirdDictionary = [
            Versions.major: 1,
        ]

        // WHEN
        let version = Version(dictionary: firstDictionary)
        let secondVersion = Version(dictionary: secondDictionary)
        let thirdVersion = Version(dictionary: thirdDictionary)

        // THEN
        XCTAssertEqual(version?.major, 1)
        XCTAssertEqual(version?.minor, 2)
        XCTAssertEqual(version?.patch, 0)
        XCTAssertEqual(secondVersion?.major, 1)
        XCTAssertEqual(secondVersion?.minor, 2)
        XCTAssertEqual(secondVersion?.patch, 0)
        XCTAssertEqual(thirdVersion?.major, 1)
        XCTAssertEqual(thirdVersion?.minor, 0)
        XCTAssertEqual(thirdVersion?.patch, 0)
    }

    func test_init_givenWrongCapture_thenReturnsNil() {
        // GIVEN
        let dictionary = [
            Versions.patch: 1,
        ]

        // WHEN
        let version = Version(dictionary: dictionary)

        // THEN
        XCTAssertNil(version)
    }

    func test_init_givenDifferentVersionFormats_thenReturnsCorrectVersions() {
        // GIVEN
        let versions = Constants.CommandVersions.allCases

        for version in versions {
            // WHEN
            let current = Version(text: version.rawValue, format: Constants.CommandVersions.format)

            // THEN
            XCTAssertEqual(current, version.correctVersion())
        }
    }

    func test_init_givenDifferentVersionFormats_andRegexMatch_thenReturnsCorrectVersions() {
        // GIVEN
        let versions = Constants.AppVersions.allCases

        for version in versions {
            // WHEN
            let current = Version(text: version.rawValue, format: Constants.AppVersions.format)

            // THEN
            XCTAssertEqual(current, version.correctVersion())
        }
    }

    func test_init_givenVersionMismatch_thenReturnsNil() {
        // GIVEN
        let versions = Constants.CommandVersions.allCases

        for version in versions {
            // WHEN
            let current = Version(text: version.rawValue, format: "Not a format")

            // THEN
            XCTAssertNil(current)
        }
    }

    func test_compare_givenDifferentVersions_thenReturnsCorrectValues() {
        // GIVEN
        let version1 = Version(1)
        let version2 = Version(2)
        let version1_0 = Version(1, 0)
        let version1_1 = Version(1, 1)
        let version1_0_1 = Version(1, 0, 1)
        let version1_0_2 = Version(1, 0, 2)
        let version1_dup = Version(1)

        // THEN
        XCTAssertTrue(version1 < version2)
        XCTAssertTrue(version1_0 < version1_1)
        XCTAssertTrue(version1_0_1 < version1_0_2)
        XCTAssertTrue(version1_dup == version1)
        XCTAssertTrue(version1_1 > version1)
        XCTAssertTrue(version1_0_1 > version1)
        XCTAssertTrue(version1_0_2 < version2)
    }
}
