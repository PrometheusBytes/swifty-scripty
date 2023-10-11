//import SwiftyScriptyTests
//@testable import SwiftyScripty
//import XCTest
//
//final class SourceryWrapperTests: ScriptTests {
//    enum Constants {
//        static let configPath = URL(string: "./tmp/config")!
//        static let templatePath = URL(string: "./tmp/template")!
//        static let sourcePath = URL(string: "./tmp/source")!
//        static let outputPath = URL(string: "./tmp/output")!
//        static let rootPath = URL(string: "User/root/tmp")!
//    }
//
//    var sut: SourceryWrapperImpl!
//    @InjectedMock(\.shell) var shellDependency: ShellMock
//    @InjectedMock(\.repository) var repositoryDependency: RepositoryMock
//
//    override func setUp() {
//        super.setUp()
//        sut = SourceryWrapperImpl()
//    }
//
//    func test_generateCode_givenConfigPath_andNoArguments_thenRunsCorrectCommand() {
//        // GIVEN
//        let configPath = Constants.configPath
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.rootPath))
//        let command = "\(Constants.rootPath.absoluteString)/Resources/ExternalLibraries/Sourcery-2.0.2/bin/sourcery --config \(Constants.configPath.absoluteString)"
//
//        // WHEN
//        let result = sut.generateCode(configPath: configPath)
//
//        // THEN
//        shellDependency.verify(
//            .runZsh(command: .value(command), executeFromRoot: .any),
//            count: 1
//        )
//        XCTAssertTrue(result)
//    }
//
//    func test_generateCode_givenNoRoot_thenReturnsFalse() {
//        // GIVEN
//        let configPath = Constants.configPath
//        repositoryDependency.given(.path(of: .any, willReturn: nil))
//
//        // WHEN
//        let result = sut.generateCode(configPath: configPath)
//
//        // THEN
//        XCTAssertFalse(result)
//    }
//
//    func test_generateCode_givenConfigPath_andArguments_thenRunsCorrectCommand() {
//        // GIVEN
//        let configPath = Constants.configPath
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.rootPath))
//        let command = "\(Constants.rootPath.absoluteString)/Resources/ExternalLibraries/Sourcery-2.0.2/bin/sourcery --config \(Constants.configPath.absoluteString) --args some=some "
//
//        // WHEN
//        let result = sut.generateCode(
//            configPath: configPath,
//            args: [
//                .init(key: "some", value: "some")
//            ]
//        )
//
//        // THEN
//        shellDependency.verify(.runZsh(command: .value(command), executeFromRoot: .any), count: 1)
//        XCTAssertTrue(result)
//    }
//
//    func test_generateCode_givenTemplateAndSource_andNoArguments_thenRunsCorrectCommand() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.rootPath))
//        let binaryPath = "\(Constants.rootPath.absoluteString)/Resources/ExternalLibraries/Sourcery-2.0.2/bin/sourcery"
//        var command = "\(binaryPath)"
//        command += " --templates \(Constants.templatePath.absoluteString)"
//        command += " --sources \(Constants.sourcePath.absoluteString)"
//        command += " --output \(Constants.outputPath.absoluteString)"
//
//        // WHEN
//        let result = sut.generateCode(
//            templatePath: Constants.templatePath,
//            sourcePath: Constants.sourcePath,
//            outputPath: Constants.outputPath
//        )
//
//        // THEN
//        shellDependency.verify(.runZsh(command: .value(command), executeFromRoot: .any), count: 1)
//        XCTAssertTrue(result)
//    }
//
//    func test_generateCode_givenTemplateAndSource_andArguments_thenRunsCorrectCommand() throws {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.rootPath))
//        let binaryPath = "\(Constants.rootPath.absoluteString)/Resources/ExternalLibraries/Sourcery-2.0.2/bin/sourcery"
//        var command = "\(binaryPath)"
//        command += " --templates \(Constants.templatePath.absoluteString)"
//        command += " --sources \(Constants.sourcePath.absoluteString)"
//        command += " --output \(Constants.outputPath.absoluteString)"
//        command += " --args some=some "
//
//        // WHEN
//        let result = sut.generateCode(
//            templatePath: Constants.templatePath,
//            sourcePath: Constants.sourcePath,
//            outputPath: Constants.outputPath,
//            args: [
//                .init(key: "some", value: "some")
//            ]
//        )
//
//        // THEN
//        shellDependency.verify(.runZsh(command: .value(command), executeFromRoot: .any), count: 1)
//        XCTAssertTrue(result)
//    }
//
//    func test_generateCode_givenNoRoot_andTemplate_thenReturnsFalse() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: nil))
//
//        // WHEN
//        let result = sut.generateCode(
//            templatePath: Constants.templatePath,
//            sourcePath: Constants.sourcePath,
//            outputPath: Constants.outputPath
//        )
//
//        // THEN
//        XCTAssertFalse(result)
//    }
//}
