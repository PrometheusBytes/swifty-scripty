// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyScripty",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftyScripty",
            targets: ["SwiftyScripty"]
        ),
        .library(
            name: "SwiftyScriptyMocks",
            targets: ["SwiftyScriptyMocks"]
        )
    ],
    dependencies: [],
    targets: [
        
        // MARK: - Swifty Scripty
        
        .target(
            name: "SwiftyScripty",
            path: "Sources/SwiftyScripty",
            resources: [.copy("Resources")],
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),

        // MARK:  Swifty Scripty Mocks

        .target(
            name: "SwiftyScriptyMocks",
            dependencies: ["SwiftyScripty"],
            path: "Mocks"
        ),

        // MARK:  Swifty Scripty Test Target
        
        .testTarget(
            name: "SwiftyScriptyTests",
            dependencies: [
                "SwiftyScripty",
                "SwiftyScriptyMocks"
            ],
            path: "Tests"
        )
    ],
    swiftLanguageVersions: [.version("6")]
)
