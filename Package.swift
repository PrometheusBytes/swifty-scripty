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
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    ],
    targets: [
        
        // MARK: - Swifty Scripty
        
        .target(
            name: "SwiftyScripty",
            path: "Sources/SwiftyScripty",
            resources: [.copy("Resources")],
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),
        
        // MARK:  Swifty Scripty Test Target
        
        .testTarget(
            name: "SwiftyScriptyTests",
            dependencies: [
                "SwiftyScripty"
            ],
            path: "Tests/SwiftyScriptyTests"
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
