// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
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
        .library(
          name: "SwiftyScriptyMacros",
          targets: ["SwiftyScriptyMacros"]
        )
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-syntax.git", from: "510.0.2")
    ],
    targets: [
        
        // MARK: - Swifty Scripty
        
        .target(
            name: "SwiftyScripty",
            dependencies: ["SwiftyScriptyMacros"],
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

        // MARK:  Swifty Scripty Macros

        .macro(
            name: "SwiftyScriptyMacros",
            dependencies: [
              .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
              .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ],
            path: "Macros"
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
    ]
)
