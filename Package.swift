// swift-tools-version: 5.7
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
        ),
        .executable(
            name: "SwiftyScriptyCLI",
            targets: ["SwiftyScriptyCLI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.5.0")),
    ],
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
            path: "Mocks/SwiftyScripty"
        ),
        
        // MARK:  Swifty Scripty CLI
        
        .executableTarget(
            name: "SwiftyScriptyCLI",
            dependencies: [
                "SwiftyScripty",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/SwiftyScriptyCLI",
            resources: [.copy("Resources")]
        ),

        // MARK:  Swifty Scripty CLI Mocks

        .target(
            name: "SwiftyScriptyCLIMocks",
            dependencies: ["SwiftyScriptyCLI"],
            path: "Mocks/SwiftyScriptyCLI"
        ),

        // MARK:  Swifty Scripty Test Target
        
        .testTarget(
            name: "SwiftyScriptyTests",
            dependencies: [
                "SwiftyScripty",
                "SwiftyScriptyMocks"
            ],
            path: "Tests/SwiftyScripty"
        ),

        // MARK:  Swifty Scripty CLI Test Target

        .testTarget(
            name: "SwiftyScriptyCLITests",
            dependencies: [
                "SwiftyScripty",
                "SwiftyScriptyMocks",
                "SwiftyScriptyCLI",
                "SwiftyScriptyCLIMocks"
            ],
            path: "Tests/SwiftyScriptyCLI"
        )
    ]
)
