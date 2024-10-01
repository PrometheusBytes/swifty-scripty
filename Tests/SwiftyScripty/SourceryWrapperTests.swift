@testable import SwiftyScripty
import SwiftyScriptyMocks
import XCTest

final class SourceryWrapperTests: XCTestCase {
    // MARK: - Constants

    enum Constants {
        static let path = URL(string: "./tmp/config")!
    }

    // MARK: - Properties

    var underTest: SourceryWrapper!
    @InjectedMock(\.shell) var shellDependency: SwiftyScriptyMocks.ShellMock

    // MARK: - SetUp

    override func setUp() {
        super.setUp()
        underTest = SourceryWrapperImpl()
    }

    // MARK: - Tests

    func test_generateCode_givenNoArguments_thenCallsCommand() async throws {
        // GIVEN
        let expectedCommand = "--config " + .configurationPathString
        shellDependency.runCommandShellTypeReturnValue = Command(
            output: "",
            errorOutput: "",
            exitCode: .successExitCode
        )

        // WHEN
        let result = await underTest.generateCode(configPath: .configurationPath)

        // THEN
        XCTAssertTrue(result.succeeded)
        XCTAssertTrue(shellDependency.runCommandShellTypeCalled)
        let command = try filter(command: shellDependency.runCommandShellTypeReceivedArguments?.command)
        XCTAssertEqual(command, expectedCommand)
    }

    func test_generateCode_givenArguments_thenCallsCommand() async throws {
        // GIVEN
        let expectedCommand = "--config " + .configurationPathString
        let expectedArgs = " --args \(String.key1)=\(String.value1),\(String.key2)=\(String.value2)"
        let expectedFullCommand = expectedCommand + expectedArgs
        shellDependency.runCommandShellTypeReturnValue = Command(
            output: "",
            errorOutput: "",
            exitCode: .successExitCode
        )

        // WHEN
        let result = await underTest.generateCode(
            configPath: .configurationPath,
            args: .args
        )

        // THEN
        XCTAssertTrue(result.succeeded)
        XCTAssertTrue(shellDependency.runCommandShellTypeCalled)
        let command = try filter(command: shellDependency.runCommandShellTypeReceivedArguments?.command)
        XCTAssertEqual(command, expectedFullCommand)
    }

    func test_generateCode_givenPaths_andArguments_thenCallsCommand() async throws {
        // GIVEN
        let expectedTemplates = "--templates " + .templatePathString
        let expectedSources = " --sources " + .sourcesPathString
        let expectedOutput = " --output " + .outputPathString
        let expectedArgs = " --args \(String.key1)=\(String.value1),\(String.key2)=\(String.value2)"
        let expectedFullCommand = expectedTemplates + expectedSources + expectedOutput + expectedArgs
        shellDependency.runCommandShellTypeReturnValue = Command(
            output: "",
            errorOutput: "",
            exitCode: .successExitCode
        )

        // WHEN
        let result = await underTest.generateCode(
            templatePath: .templatePath,
            sourcePath: .sourcesPath,
            outputPath: .outputPath,
            args: .args,
            trimSourceryHeader: true
        )

        // THEN
        XCTAssertTrue(result.succeeded)
        XCTAssertTrue(shellDependency.runCommandShellTypeCalled)
        let command = try filter(command: shellDependency.runCommandShellTypeReceivedArguments?.command)
        XCTAssertEqual(command, expectedFullCommand)
    }
}

// MARK: - Helper Functions

private extension SourceryWrapperTests {
    func filter(command: String?) throws -> String {
        let value = try XCTUnwrap(command)
        var filteredValue = value.split(separator: " ")
        filteredValue.removeFirst()
        return filteredValue.joined(separator: " ")
    }
}

// MARK: - Constants

fileprivate extension URL {
    static let configurationPath = URL(string: .configurationPathString)!
    static let templatePath = URL(string: .templatePathString)!
    static let sourcesPath = URL(string: .sourcesPathString)!
    static let outputPath = URL(string: .outputPathString)!
}

fileprivate extension String {
    static let configurationPathString = "User/Configuration"
    static let templatePathString = "User/Templates"
    static let sourcesPathString = "User/Sources"
    static let outputPathString = "User/Output"
    static let key1 = "key_1"
    static let key2 = "key_2"
    static let value1 = "value_1"
    static let value2 = "value_2"
}

fileprivate extension Array<SourceryWrapperArguments> {
    static let args = [
        SourceryWrapperArguments(key: .key1, value: .value1),
        SourceryWrapperArguments(key: .key2, value: .value2)
    ]
}
