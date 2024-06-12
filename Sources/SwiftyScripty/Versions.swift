import Foundation

/// An enumeration representing version components.
public enum Versions: String, CaseIterable {
    /// The major version component.
    case major
    
    /// The minor version component.
    case minor
    
    /// The patch version component.
    case patch
}

/// A structure representing a version number.
public struct Version: Equatable, Comparable {
    /// The major version number.
    let major: Int
    
    /// The minor version number.
    let minor: Int
    
    /// The patch version number.
    let patch: Int

    /// A zero-initialized version.
    static let zero = Version(0)

    /// Initializes a Version structure with the specified major, minor, and patch numbers.
    ///
    /// - Parameters:
    ///   - major: The major version number.
    ///   - minor: The minor version number. Default value is `0`.
    ///   - patch: The patch version number. Default value is `0`.
    public init(_ major: Int, _ minor: Int? = nil, _ patch: Int? = nil) {
        self.major = major
        self.minor = minor ?? 0
        self.patch = patch ?? 0
    }

    /// Initializes a Version structure using a dictionary of version components.
    ///
    /// > Example:
    ///
    /// ```
    /// let versionDict = [
    ///     Versions.major: 2,
    ///     Versions.minor: 1,
    ///     Versions.patch: 3
    /// ]
    ///
    /// let version = Version(dictionary: versionDict)
    /// ```
    ///
    /// - Parameters:
    ///   - dictionary: A dictionary containing version components.
    public init?(dictionary: [Versions: Int]) {
        guard let major = dictionary[.major] else {
            return nil
        }

        self.major = major
        self.minor = dictionary[.minor] ?? 0
        self.patch = dictionary[.patch] ?? 0
    }

    /// Initializes a Version structure using a text and a format string.
    /// The format passed should replace the version string with `<version>`.
    ///
    /// > Example:
    ///
    /// ```
    /// let version = Version(
    ///     text: "The app version is 2.2.1 currently",
    ///     format: "The app version is <version> currently"
    /// )
    /// ```
    ///
    /// - Parameters:
    ///   - text: The text containing the version information.
    ///   - format: The format string specifying how to extract the version information from the text.
    public init?(text: String, format: String) {
        let versionString = "(?<\(Versions.major.rawValue)>\\d+).?(?<\(Versions.minor.rawValue)>\\d*).?(?<\(Versions.patch.rawValue)>\\d*)"

        guard let regex = try? NSRegularExpression(
            pattern: format.replacingOccurrences(of: "<version>", with: versionString)
        )
        else {
            return nil
        }

        let fullRange = NSRange(
            text.startIndex..<text.endIndex,
            in: text
        )

        guard let match = regex.matches(in: text, range: fullRange).first else {
            return nil
        }

        var captures: [Versions: Int] = [:]

        for version in Versions.allCases {
            let matchRange = match.range(withName: version.rawValue)
            if let substringRange = Range(matchRange, in: text) {
                let capture = String(text[substringRange])
                captures[version] = Int(capture) ?? 0
            }
        }

        self.init(dictionary: captures)
    }

    /// Compares two Version structures.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side Version to compare.
    ///   - rhs: The right-hand side Version to compare.
    /// - Returns: `true` if lhs is less than rhs; otherwise, `false`.
    public static func < (lhs: Version, rhs: Version) -> Bool {
        guard lhs.major == rhs.major else {
            return lhs.major < rhs.major
        }

        guard lhs.minor == rhs.minor else {
            return lhs.minor < rhs.minor
        }

        return lhs.patch < rhs.patch
    }
}
