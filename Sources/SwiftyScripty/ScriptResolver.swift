//import Foundation
//
////sourcery: AutoMockable
//public protocol ScriptResolver {
//    @discardableResult
//    func execute(script: Scripts, arguments: [String], returnOutput: Bool) -> Command?
//    @discardableResult
//    func callMake(of script: Scripts, target: String, arguments: [String], returnOutput: Bool) -> Command?
//}
//
//public extension ScriptResolver {
//    @discardableResult
//    func execute(
//        script: Scripts,
//        arguments: [String] = [],
//        returnOutput: Bool = false
//    ) -> Command? {
//        execute(script: script, arguments: arguments, returnOutput: returnOutput)
//    }
//
//    @discardableResult
//    func callMake(
//        of script: Scripts,
//        target: String,
//        arguments: [String] = [],
//        returnOutput: Bool = false
//    ) -> Command? {
//        callMake(of: script, target: target, arguments: arguments, returnOutput: returnOutput)
//    }
//}
//
//struct ScriptResolverImpl: ScriptResolver {
//    @Injected(\.shell) var shell: Shell
//    @Injected(\.repository) var repository: Repository
//    
//    @discardableResult
//    func execute(script: Scripts, arguments: [String], returnOutput: Bool) -> Command? {
//        guard let swiftScriptsPath = repository.path(of: .sources) else {
//            return nil
//        }
//
//        let scriptPath = swiftScriptsPath.absoluteString.appending("/\(script.rawValue)/\(script.rawValue)")
//        var command = "\(scriptPath)"
//
//        if !arguments.isEmpty {
//            arguments.forEach { arg in
//                command.append(" \(arg)")
//            }
//        }
//
//        if returnOutput {
//            return shell.zshWithExitCode(command: command)
//        }
//
//        shell.runZsh(command: command)
//        return nil
//    }
//
//    @discardableResult
//    func callMake(of script: Scripts, target: String, arguments: [String], returnOutput: Bool) -> Command? {
//        guard let swiftScriptsPath = repository.path(of: .sources) else {
//            return nil
//        }
//
//        let scriptPath = swiftScriptsPath.absoluteString.appending("/\(script.rawValue)")
//        let goToCommand = "cd \(scriptPath)"
//        var makeCommand = "make \(target)"
//
//        if !arguments.isEmpty {
//            arguments.forEach { arg in
//                makeCommand.append(" \(arg)")
//            }
//        }
//
//        if returnOutput {
//            return shell.zshWithExitCode(command: "\(goToCommand); \(makeCommand)")
//        }
//
//        shell.runZsh(command: "\(goToCommand); \(makeCommand)")
//        return nil
//    }
//}
