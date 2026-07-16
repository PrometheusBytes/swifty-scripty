// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

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
        ),
        .executable(
            name: "SwiftyScriptyExecutable",
            targets: ["SwiftyScriptyExecutable"]
        ),
        .executable(
            name: "SwiftyScriptyApp",
            targets: ["SwiftyScriptyApp"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0"),
    ],
    targets: [
        
        // MARK: - Swifty Scripty
        
        .target(
            name: "SwiftyScripty",
            dependencies: ["SwiftyScriptyAppViews", "SwiftyScriptyMacros"],
            path: "Sources/SwiftyScripty",
            resources: [.copy("Resources")],
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),

        // MARK: - Swifty Scripty App

        .executableTarget(
            name: "SwiftyScriptyApp",
            dependencies: ["SwiftyScripty", "SwiftyScriptyAppViews"],
            path: "Sources/SwiftyScriptyApp"
        ),

        // MARK: - Swifty Scripty App Views

        .target(
            name: "SwiftyScriptyAppViews",
            path: "Sources/SwiftyScriptyAppViews"
        ),

        // MARK:  Swifty Scripty Mocks

        .target(
            name: "SwiftyScriptyMocks",
            dependencies: ["SwiftyScripty"],
            path: "Mocks/SwiftyScripty"
        ),
        
        // MARK:  Swifty Scripty CLI

        .target(
            name: "SwiftyScriptyCLI",
            dependencies: [
                "SwiftyScripty",
                "SwiftyScriptyMacros",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/SwiftyScriptyCLI",
            resources: [.copy("Resources")]
        ),

        .executableTarget(
            name: "SwiftyScriptyExecutable",
            dependencies: [
                "SwiftyScriptyCLI",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/SwiftyScriptyExecutable"
        ),

        // MARK:  Swifty Scripty CLI Mocks

        .target(
            name: "SwiftyScriptyCLIMocks",
            dependencies: ["SwiftyScriptyCLI"],
            path: "Mocks/SwiftyScriptyCLI"
        ),
        
        // MARK: Swifty Scripty Macros
        
        .target(
            name: "SwiftyScriptyMacros",
            dependencies: ["SwiftyScriptyMacrosPlugin"],
            path: "Sources/SwiftyScriptyMacros/Macros"
        ),
        
        .macro(
            name: "SwiftyScriptyMacrosPlugin",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ],
            path: "Sources/SwiftyScriptyMacros/Plugin"
        ),
        
        .executableTarget(
            name: "SwiftyScriptyMacrosClient",
            dependencies: ["SwiftyScriptyMacros"],
            path: "Sources/SwiftyScriptyMacros/Client"
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
        ),

        .testTarget(
            name: "SwiftyScriptyMacrosTests",
            dependencies: [
                "SwiftyScriptyMacrosPlugin",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
            ],
            path: "Tests/SwiftyScriptyMacrosTests"
        )
    ]
)
