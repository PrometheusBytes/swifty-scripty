import Foundation

public enum Versions: String, CaseIterable {
    case major
    case minor
    case patch
}

public struct Version: Equatable, Comparable {
    let major: Int
    let minor: Int
    let patch: Int

    static let zero = Version(0)

    public init(_ major: Int, _ minor: Int? = nil, _ patch: Int? = nil) {
        self.major = major
        self.minor = minor ?? 0
        self.patch = patch ?? 0
    }

    /// A way to init a version using a dictionary
    ///
    /// This init allows to translate a dictionary of `Versions: Int` into a `Version`.
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
    ///   - dictionary: The dictionary used to create the Version.
    public init?(dictionary: [Versions: Int]) {
        guard let major = dictionary[.major] else {
            return nil
        }

        self.major = major
        self.minor = dictionary[.minor] ?? 0
        self.patch = dictionary[.patch] ?? 0
    }

    /// A way to init a version using a string and a format.
    ///
    /// This init allows to translate any string into a version.
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
    ///   - text: The text to be parsed.
    ///   - format: The format used to parse the text.
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
