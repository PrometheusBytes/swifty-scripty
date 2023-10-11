// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyScripty",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftyScripty",
            targets: ["SwiftyScripty"]
        ),
        .library(
            name: "SwiftyScriptyTests",
            targets: ["SwiftyScriptyTests"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", branch: "master"),
        .package(url: "https://github.com/jpsim/Yams", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    ],
    targets: [
        
        // MARK: - Swifty Scripty
        
        .target(
            name: "SwiftyScripty",
            dependencies: ["Yams"],
            path: "Sources/SwiftyScripty",
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),
        
        // MARK:  Swifty Scripty Tests
        
        .target(
            name: "SwiftyScriptyTests",
            dependencies: [
                "SwiftyScripty",
                "SwiftyMocky"
            ],
            path: "Sources/SwiftyScriptyTests"
        ),
        
        // MARK:  Swifty Scripty Test Target
        
        .testTarget(
            name: "SwiftyScriptyTestSuite",
            dependencies: [
                "SwiftyScripty",
                "SwiftyScriptyTests",
                "SwiftyMocky"
            ],
            path: "Tests/SwiftyScriptyTestSuite"
        ),

        // MARK: - Clean Script

        .executableTarget(
            name: "CleanScript",
            dependencies: [
                "SwiftyScripty",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/CleanScript",
            swiftSettings: [.unsafeFlags(["-enable-bare-slash-regex"])]
        ),

        // MARK: - Make Swift Script

        .executableTarget(
            name: "MakeSwiftScript",
            dependencies: [
                "SwiftyScripty",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/MakeSwiftScript"
        ),

        // MARK: - Setup Script

        .executableTarget(
            name: "SetupScript",
            dependencies: [
                "SwiftyScripty",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/SetupScript"
        )
    ]
)
