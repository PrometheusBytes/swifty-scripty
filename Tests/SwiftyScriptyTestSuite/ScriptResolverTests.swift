//import SwiftyScriptyTests
//@testable import SwiftyScripty
//import XCTest
//
//final class ScriptResolverTests: ScriptTests {
//    enum Constants {
//        static let pathString = "Users/Matteo/swift-scripts"
//        static let path = URL(string: Constants.pathString)!
//        static let arguments = ["firstArg", "secondArg"]
//        static let someOutput = "Some Output"
//    }
//
////    var sut: ScriptResolverImpl!
//    @InjectedMock(\.shell) var shellDependency: ShellMock
//    @InjectedMock(\.repository) var repositoryDependency: RepositoryMock
//
//    override func setUp() {
//        super.setUp()
//        sut = ScriptResolverImpl()
//    }
//
//    func test_execute_givenScript_andNoArguments_thenCallsRightCommand() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.path))
//
//        let script: Scripts = .cleanScript
//        let command = "\(Constants.pathString)/\(script.rawValue)/\(script.rawValue)"
//
//        // WHEN
//        sut.execute(script: .cleanScript)
//
//        // THEN
//        shellDependency.verify(
//            .runZsh(command: .value(command), executeFromRoot: .any),
//            count: 1
//        )
//    }
//
//    func test_execute_givenScript_andNoRepositoryPath_thenReturnsNil() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: nil))
//
//        // WHEN
//        sut.execute(script: .cleanScript)
//
//        // THEN
//        shellDependency.verify(
//            .runZsh(command: .any, executeFromRoot: .any),
//            count: 0
//        )
//    }
//
//    func test_execute_givenScript_andArguments_thenCallsRightCommand() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.path))
//        let script: Scripts = .cleanScript
//        let command = "\(Constants.pathString)/\(script.rawValue)/\(script.rawValue) \(Constants.arguments.first ?? "") \(Constants.arguments.last ?? "")"
//
//        // WHEN
//        sut.execute(script: .cleanScript, arguments: Constants.arguments)
//
//        // THEN
//        shellDependency.verify(
//            .runZsh(command: .value(command), executeFromRoot: .any),
//            count: 1
//        )
//    }
//
//    func test_execute_givenScript_andArguments_andReturnOutput_thenReturnsCorrectOutput() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.path))
//        let script: Scripts = .cleanScript
//        let command = "\(Constants.pathString)/\(script.rawValue)/\(script.rawValue) \(Constants.arguments.first ?? "") \(Constants.arguments.last ?? "")"
//        shellDependency.given(
//            .zshWithExitCode(
//                command: .value(command),
//                executeFromRoot: .any,
//                willReturn: Command(
//                    output: Constants.someOutput,
//                    errorOutput: "",
//                    exitCode: .successExitCode
//                )
//            )
//        )
//
//        // WHEN
//        let value = sut.execute(
//            script: .cleanScript,
//            arguments: Constants.arguments,
//            returnOutput: true
//        )
//
//        // THEN
//        XCTAssertEqual(value?.output, Constants.someOutput)
//        XCTAssertEqual(value?.exitCode, .successExitCode)
//    }
//
//    func test_callMake_givenNoRepository_thenReturns() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: nil))
//
//        // WHEN
//        sut.callMake(of: .cleanScript, target: "mocks")
//
//        // THEN
//        shellDependency.verify(
//            .runZsh(command: .any, executeFromRoot: .any),
//            count: 0
//        )
//    }
//
//    func test_callMake_givenRepository_andNoArguments_thenCallsCorrectCommmand() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.path))
//        let script: Scripts = .cleanScript
//        let goToCommand = "cd \(Constants.pathString)/\(script.rawValue)"
//        let makeCommand = "make mocks"
//
//        // WHEN
//        sut.callMake(of: .cleanScript, target: "mocks")
//
//        // THEN
//        shellDependency.verify(
//            .runZsh(command: .value("\(goToCommand); \(makeCommand)"), executeFromRoot: .any),
//            count: 1
//        )
//    }
//
//    func test_callMake_givenRepository_andArguments_thenCallsCorrectCommmand() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.path))
//        let script: Scripts = .cleanScript
//        let goToCommand = "cd \(Constants.pathString)/\(script.rawValue)"
//        let makeCommand = "make mocks"
//
//        // WHEN
//        sut.callMake(of: .cleanScript, target: "mocks", arguments: ["arg1", "arg2"])
//
//        // THEN
//        shellDependency.verify(
//            .runZsh(command: .value("\(goToCommand); \(makeCommand) arg1 arg2"), executeFromRoot: .any),
//            count: 1
//        )
//    }
//
//    func test_callMake_givenRepository_andArguments_andReturnValue_thenReturnsCorrectValues() {
//        // GIVEN
//        repositoryDependency.given(.path(of: .any, willReturn: Constants.path))
//        let script: Scripts = .cleanScript
//        let goToCommand = "cd \(Constants.pathString)/\(script.rawValue)"
//        let makeCommand = "make mocks"
//        let fullCommand = "\(goToCommand); \(makeCommand) arg1 arg2"
//        shellDependency.given(
//            .zshWithExitCode(
//                command: .value(fullCommand),
//                executeFromRoot: .any,
//                willReturn: Command(
//                    output: Constants.someOutput,
//                    errorOutput: "",
//                    exitCode: .errorExitCode
//                )
//            )
//        )
//
//        // WHEN
//        let value = sut.callMake(
//            of: .cleanScript, target: "mocks",
//            arguments: ["arg1", "arg2"],
//            returnOutput: true
//        )
//
//        // THEN
//        XCTAssertEqual(value?.output, Constants.someOutput)
//        XCTAssertEqual(value?.exitCode, .errorExitCode)
//    }
//}
