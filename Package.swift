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
    dependencies: [],
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
        )
    ]
)
