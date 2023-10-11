// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: SwiftLint rules
//swiftlint:disable all

// MARK: Imports

import SwiftyMocky
import XCTest
import Foundation
import SwiftyScripty
// MARK: - SourceryWrapper

open class SourceryWrapperMock: SourceryWrapper, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func generateCode(configPath: URL, args: [SourceryWrapperArguments]) -> Bool {
        addInvocation(.m_generateCode__configPath_configPathargs_args(Parameter<URL>.value(`configPath`), Parameter<[SourceryWrapperArguments]>.value(`args`)))
		let perform = methodPerformValue(.m_generateCode__configPath_configPathargs_args(Parameter<URL>.value(`configPath`), Parameter<[SourceryWrapperArguments]>.value(`args`))) as? (URL, [SourceryWrapperArguments]) -> Void
		perform?(`configPath`, `args`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_generateCode__configPath_configPathargs_args(Parameter<URL>.value(`configPath`), Parameter<[SourceryWrapperArguments]>.value(`args`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for generateCode(configPath: URL, args: [SourceryWrapperArguments]). Use given")
			Failure("Stub return value not specified for generateCode(configPath: URL, args: [SourceryWrapperArguments]). Use given")
		}
		return __value
    }

    open func generateCode(templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments]) -> Bool {
        addInvocation(.m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(Parameter<[URL]>.value(`templatePaths`), Parameter<[URL]>.value(`sourcePaths`), Parameter<URL>.value(`outputPath`), Parameter<[SourceryWrapperArguments]>.value(`args`)))
		let perform = methodPerformValue(.m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(Parameter<[URL]>.value(`templatePaths`), Parameter<[URL]>.value(`sourcePaths`), Parameter<URL>.value(`outputPath`), Parameter<[SourceryWrapperArguments]>.value(`args`))) as? ([URL], [URL], URL, [SourceryWrapperArguments]) -> Void
		perform?(`templatePaths`, `sourcePaths`, `outputPath`, `args`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(Parameter<[URL]>.value(`templatePaths`), Parameter<[URL]>.value(`sourcePaths`), Parameter<URL>.value(`outputPath`), Parameter<[SourceryWrapperArguments]>.value(`args`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for generateCode(templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments]). Use given")
			Failure("Stub return value not specified for generateCode(templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments]). Use given")
		}
		return __value
    }

    open func generateCode(templatePath: URL, sourcePath: URL, outputPath: URL, args: [SourceryWrapperArguments] = []) -> Bool {
        addInvocation(.m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(Parameter<URL>.value(`templatePath`), Parameter<URL>.value(`sourcePath`), Parameter<URL>.value(`outputPath`), Parameter<[SourceryWrapperArguments]>.value(`args`)))
		let perform = methodPerformValue(.m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(Parameter<URL>.value(`templatePath`), Parameter<URL>.value(`sourcePath`), Parameter<URL>.value(`outputPath`), Parameter<[SourceryWrapperArguments]>.value(`args`))) as? (URL, URL, URL, [SourceryWrapperArguments]) -> Void
		perform?(`templatePath`, `sourcePath`, `outputPath`, `args`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(Parameter<URL>.value(`templatePath`), Parameter<URL>.value(`sourcePath`), Parameter<URL>.value(`outputPath`), Parameter<[SourceryWrapperArguments]>.value(`args`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for generateCode(templatePath: URL, sourcePath: URL, outputPath: URL, args: [SourceryWrapperArguments] = []). Use given")
			Failure("Stub return value not specified for generateCode(templatePath: URL, sourcePath: URL, outputPath: URL, args: [SourceryWrapperArguments] = []). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_generateCode__configPath_configPathargs_args(Parameter<URL>, Parameter<[SourceryWrapperArguments]>)
        case m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(Parameter<[URL]>, Parameter<[URL]>, Parameter<URL>, Parameter<[SourceryWrapperArguments]>)
        case m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(Parameter<URL>, Parameter<URL>, Parameter<URL>, Parameter<[SourceryWrapperArguments]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_generateCode__configPath_configPathargs_args(let lhsConfigpath, let lhsArgs), .m_generateCode__configPath_configPathargs_args(let rhsConfigpath, let rhsArgs)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConfigpath, rhs: rhsConfigpath, with: matcher), lhsConfigpath, rhsConfigpath, "configPath"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsArgs, rhs: rhsArgs, with: matcher), lhsArgs, rhsArgs, "args"))
				return Matcher.ComparisonResult(results)

            case (.m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(let lhsTemplatepaths, let lhsSourcepaths, let lhsOutputpath, let lhsArgs), .m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(let rhsTemplatepaths, let rhsSourcepaths, let rhsOutputpath, let rhsArgs)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTemplatepaths, rhs: rhsTemplatepaths, with: matcher), lhsTemplatepaths, rhsTemplatepaths, "templatePaths"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSourcepaths, rhs: rhsSourcepaths, with: matcher), lhsSourcepaths, rhsSourcepaths, "sourcePaths"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOutputpath, rhs: rhsOutputpath, with: matcher), lhsOutputpath, rhsOutputpath, "outputPath"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsArgs, rhs: rhsArgs, with: matcher), lhsArgs, rhsArgs, "args"))
				return Matcher.ComparisonResult(results)

            case (.m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(let lhsTemplatepath, let lhsSourcepath, let lhsOutputpath, let lhsArgs), .m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(let rhsTemplatepath, let rhsSourcepath, let rhsOutputpath, let rhsArgs)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTemplatepath, rhs: rhsTemplatepath, with: matcher), lhsTemplatepath, rhsTemplatepath, "templatePath"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSourcepath, rhs: rhsSourcepath, with: matcher), lhsSourcepath, rhsSourcepath, "sourcePath"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOutputpath, rhs: rhsOutputpath, with: matcher), lhsOutputpath, rhsOutputpath, "outputPath"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsArgs, rhs: rhsArgs, with: matcher), lhsArgs, rhsArgs, "args"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_generateCode__configPath_configPathargs_args(p0, p1): return p0.intValue + p1.intValue
            case let .m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_generateCode__configPath_configPathargs_args: return ".generateCode(configPath:args:)"
            case .m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args: return ".generateCode(templatePaths:sourcePaths:outputPath:args:)"
            case .m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args: return ".generateCode(templatePath:sourcePath:outputPath:args:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func generateCode(configPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_generateCode__configPath_configPathargs_args(`configPath`, `args`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func generateCode(templatePaths: Parameter<[URL]>, sourcePaths: Parameter<[URL]>, outputPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(`templatePaths`, `sourcePaths`, `outputPath`, `args`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func generateCode(templatePath: Parameter<URL>, sourcePath: Parameter<URL>, outputPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(`templatePath`, `sourcePath`, `outputPath`, `args`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func generateCode(configPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_generateCode__configPath_configPathargs_args(`configPath`, `args`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func generateCode(templatePaths: Parameter<[URL]>, sourcePaths: Parameter<[URL]>, outputPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(`templatePaths`, `sourcePaths`, `outputPath`, `args`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func generateCode(templatePath: Parameter<URL>, sourcePath: Parameter<URL>, outputPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(`templatePath`, `sourcePath`, `outputPath`, `args`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func generateCode(configPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>) -> Verify { return Verify(method: .m_generateCode__configPath_configPathargs_args(`configPath`, `args`))}
        public static func generateCode(templatePaths: Parameter<[URL]>, sourcePaths: Parameter<[URL]>, outputPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>) -> Verify { return Verify(method: .m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(`templatePaths`, `sourcePaths`, `outputPath`, `args`))}
        public static func generateCode(templatePath: Parameter<URL>, sourcePath: Parameter<URL>, outputPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>) -> Verify { return Verify(method: .m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(`templatePath`, `sourcePath`, `outputPath`, `args`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func generateCode(configPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, perform: @escaping (URL, [SourceryWrapperArguments]) -> Void) -> Perform {
            return Perform(method: .m_generateCode__configPath_configPathargs_args(`configPath`, `args`), performs: perform)
        }
        public static func generateCode(templatePaths: Parameter<[URL]>, sourcePaths: Parameter<[URL]>, outputPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, perform: @escaping ([URL], [URL], URL, [SourceryWrapperArguments]) -> Void) -> Perform {
            return Perform(method: .m_generateCode__templatePaths_templatePathssourcePaths_sourcePathsoutputPath_outputPathargs_args(`templatePaths`, `sourcePaths`, `outputPath`, `args`), performs: perform)
        }
        public static func generateCode(templatePath: Parameter<URL>, sourcePath: Parameter<URL>, outputPath: Parameter<URL>, args: Parameter<[SourceryWrapperArguments]>, perform: @escaping (URL, URL, URL, [SourceryWrapperArguments]) -> Void) -> Perform {
            return Perform(method: .m_generateCode__templatePath_templatePathsourcePath_sourcePathoutputPath_outputPathargs_args(`templatePath`, `sourcePath`, `outputPath`, `args`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}
