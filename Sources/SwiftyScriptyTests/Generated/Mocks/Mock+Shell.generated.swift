// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: SwiftLint rules
//swiftlint:disable all

// MARK: Imports

import SwiftyMocky
import XCTest
import Foundation
import SwiftyScripty
// MARK: - Shell

open class ShellMock: Shell, Mock {
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





    open func bash(command: String) -> String? {
        addInvocation(.m_bash__command_command(Parameter<String>.value(`command`)))
		let perform = methodPerformValue(.m_bash__command_command(Parameter<String>.value(`command`))) as? (String) -> Void
		perform?(`command`)
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_bash__command_command(Parameter<String>.value(`command`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func bashWithExitCode(command: String) -> Command? {
        addInvocation(.m_bashWithExitCode__command_command(Parameter<String>.value(`command`)))
		let perform = methodPerformValue(.m_bashWithExitCode__command_command(Parameter<String>.value(`command`))) as? (String) -> Void
		perform?(`command`)
		var __value: Command? = nil
		do {
		    __value = try methodReturnValue(.m_bashWithExitCode__command_command(Parameter<String>.value(`command`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    @discardableResult
	open func runBash(command: String) -> Int32? {
        addInvocation(.m_runBash__command_command(Parameter<String>.value(`command`)))
		let perform = methodPerformValue(.m_runBash__command_command(Parameter<String>.value(`command`))) as? (String) -> Void
		perform?(`command`)
		var __value: Int32? = nil
		do {
		    __value = try methodReturnValue(.m_runBash__command_command(Parameter<String>.value(`command`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func zsh(command: String) -> String? {
        addInvocation(.m_zsh__command_command(Parameter<String>.value(`command`)))
		let perform = methodPerformValue(.m_zsh__command_command(Parameter<String>.value(`command`))) as? (String) -> Void
		perform?(`command`)
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_zsh__command_command(Parameter<String>.value(`command`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func zshWithExitCode(command: String) -> Command? {
        addInvocation(.m_zshWithExitCode__command_command(Parameter<String>.value(`command`)))
		let perform = methodPerformValue(.m_zshWithExitCode__command_command(Parameter<String>.value(`command`))) as? (String) -> Void
		perform?(`command`)
		var __value: Command? = nil
		do {
		    __value = try methodReturnValue(.m_zshWithExitCode__command_command(Parameter<String>.value(`command`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    @discardableResult
	open func runZsh(command: String) -> Int32? {
        addInvocation(.m_runZsh__command_command(Parameter<String>.value(`command`)))
		let perform = methodPerformValue(.m_runZsh__command_command(Parameter<String>.value(`command`))) as? (String) -> Void
		perform?(`command`)
		var __value: Int32? = nil
		do {
		    __value = try methodReturnValue(.m_runZsh__command_command(Parameter<String>.value(`command`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func readZshVar(key: String) -> String? {
        addInvocation(.m_readZshVar__key_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_readZshVar__key_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_readZshVar__key_key(Parameter<String>.value(`key`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func readBashVar(key: String) -> String? {
        addInvocation(.m_readBashVar__key_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_readBashVar__key_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_readBashVar__key_key(Parameter<String>.value(`key`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func askQuestion(question: String) -> String? {
        addInvocation(.m_askQuestion__question_question(Parameter<String>.value(`question`)))
		let perform = methodPerformValue(.m_askQuestion__question_question(Parameter<String>.value(`question`))) as? (String) -> Void
		perform?(`question`)
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_askQuestion__question_question(Parameter<String>.value(`question`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func askPermission(question: String) -> Bool {
        addInvocation(.m_askPermission__question_question(Parameter<String>.value(`question`)))
		let perform = methodPerformValue(.m_askPermission__question_question(Parameter<String>.value(`question`))) as? (String) -> Void
		perform?(`question`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_askPermission__question_question(Parameter<String>.value(`question`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for askPermission(question: String). Use given")
			Failure("Stub return value not specified for askPermission(question: String). Use given")
		}
		return __value
    }

    open func print(color: ANSIColors, text: String) {
        addInvocation(.m_print__color_colortext_text(Parameter<ANSIColors>.value(`color`), Parameter<String>.value(`text`)))
		let perform = methodPerformValue(.m_print__color_colortext_text(Parameter<ANSIColors>.value(`color`), Parameter<String>.value(`text`))) as? (ANSIColors, String) -> Void
		perform?(`color`, `text`)
    }

    open func exit(with code: Int32) {
        addInvocation(.m_exit__with_code(Parameter<Int32>.value(`code`)))
		let perform = methodPerformValue(.m_exit__with_code(Parameter<Int32>.value(`code`))) as? (Int32) -> Void
		perform?(`code`)
    }


    fileprivate enum MethodType {
        case m_bash__command_command(Parameter<String>)
        case m_bashWithExitCode__command_command(Parameter<String>)
        case m_runBash__command_command(Parameter<String>)
        case m_zsh__command_command(Parameter<String>)
        case m_zshWithExitCode__command_command(Parameter<String>)
        case m_runZsh__command_command(Parameter<String>)
        case m_readZshVar__key_key(Parameter<String>)
        case m_readBashVar__key_key(Parameter<String>)
        case m_askQuestion__question_question(Parameter<String>)
        case m_askPermission__question_question(Parameter<String>)
        case m_print__color_colortext_text(Parameter<ANSIColors>, Parameter<String>)
        case m_exit__with_code(Parameter<Int32>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_bash__command_command(let lhsCommand), .m_bash__command_command(let rhsCommand)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCommand, rhs: rhsCommand, with: matcher), lhsCommand, rhsCommand, "command"))
				return Matcher.ComparisonResult(results)

            case (.m_bashWithExitCode__command_command(let lhsCommand), .m_bashWithExitCode__command_command(let rhsCommand)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCommand, rhs: rhsCommand, with: matcher), lhsCommand, rhsCommand, "command"))
				return Matcher.ComparisonResult(results)

            case (.m_runBash__command_command(let lhsCommand), .m_runBash__command_command(let rhsCommand)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCommand, rhs: rhsCommand, with: matcher), lhsCommand, rhsCommand, "command"))
				return Matcher.ComparisonResult(results)

            case (.m_zsh__command_command(let lhsCommand), .m_zsh__command_command(let rhsCommand)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCommand, rhs: rhsCommand, with: matcher), lhsCommand, rhsCommand, "command"))
				return Matcher.ComparisonResult(results)

            case (.m_zshWithExitCode__command_command(let lhsCommand), .m_zshWithExitCode__command_command(let rhsCommand)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCommand, rhs: rhsCommand, with: matcher), lhsCommand, rhsCommand, "command"))
				return Matcher.ComparisonResult(results)

            case (.m_runZsh__command_command(let lhsCommand), .m_runZsh__command_command(let rhsCommand)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCommand, rhs: rhsCommand, with: matcher), lhsCommand, rhsCommand, "command"))
				return Matcher.ComparisonResult(results)

            case (.m_readZshVar__key_key(let lhsKey), .m_readZshVar__key_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "key"))
				return Matcher.ComparisonResult(results)

            case (.m_readBashVar__key_key(let lhsKey), .m_readBashVar__key_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "key"))
				return Matcher.ComparisonResult(results)

            case (.m_askQuestion__question_question(let lhsQuestion), .m_askQuestion__question_question(let rhsQuestion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuestion, rhs: rhsQuestion, with: matcher), lhsQuestion, rhsQuestion, "question"))
				return Matcher.ComparisonResult(results)

            case (.m_askPermission__question_question(let lhsQuestion), .m_askPermission__question_question(let rhsQuestion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuestion, rhs: rhsQuestion, with: matcher), lhsQuestion, rhsQuestion, "question"))
				return Matcher.ComparisonResult(results)

            case (.m_print__color_colortext_text(let lhsColor, let lhsText), .m_print__color_colortext_text(let rhsColor, let rhsText)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsColor, rhs: rhsColor, with: matcher), lhsColor, rhsColor, "color"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher), lhsText, rhsText, "text"))
				return Matcher.ComparisonResult(results)

            case (.m_exit__with_code(let lhsCode), .m_exit__with_code(let rhsCode)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCode, rhs: rhsCode, with: matcher), lhsCode, rhsCode, "with code"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_bash__command_command(p0): return p0.intValue
            case let .m_bashWithExitCode__command_command(p0): return p0.intValue
            case let .m_runBash__command_command(p0): return p0.intValue
            case let .m_zsh__command_command(p0): return p0.intValue
            case let .m_zshWithExitCode__command_command(p0): return p0.intValue
            case let .m_runZsh__command_command(p0): return p0.intValue
            case let .m_readZshVar__key_key(p0): return p0.intValue
            case let .m_readBashVar__key_key(p0): return p0.intValue
            case let .m_askQuestion__question_question(p0): return p0.intValue
            case let .m_askPermission__question_question(p0): return p0.intValue
            case let .m_print__color_colortext_text(p0, p1): return p0.intValue + p1.intValue
            case let .m_exit__with_code(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_bash__command_command: return ".bash(command:)"
            case .m_bashWithExitCode__command_command: return ".bashWithExitCode(command:)"
            case .m_runBash__command_command: return ".runBash(command:)"
            case .m_zsh__command_command: return ".zsh(command:)"
            case .m_zshWithExitCode__command_command: return ".zshWithExitCode(command:)"
            case .m_runZsh__command_command: return ".runZsh(command:)"
            case .m_readZshVar__key_key: return ".readZshVar(key:)"
            case .m_readBashVar__key_key: return ".readBashVar(key:)"
            case .m_askQuestion__question_question: return ".askQuestion(question:)"
            case .m_askPermission__question_question: return ".askPermission(question:)"
            case .m_print__color_colortext_text: return ".print(color:text:)"
            case .m_exit__with_code: return ".exit(with:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func bash(command: Parameter<String>, willReturn: String?...) -> MethodStub {
            return Given(method: .m_bash__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func bashWithExitCode(command: Parameter<String>, willReturn: Command?...) -> MethodStub {
            return Given(method: .m_bashWithExitCode__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        @discardableResult
		public static func runBash(command: Parameter<String>, willReturn: Int32?...) -> MethodStub {
            return Given(method: .m_runBash__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func zsh(command: Parameter<String>, willReturn: String?...) -> MethodStub {
            return Given(method: .m_zsh__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func zshWithExitCode(command: Parameter<String>, willReturn: Command?...) -> MethodStub {
            return Given(method: .m_zshWithExitCode__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        @discardableResult
		public static func runZsh(command: Parameter<String>, willReturn: Int32?...) -> MethodStub {
            return Given(method: .m_runZsh__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func readZshVar(key: Parameter<String>, willReturn: String?...) -> MethodStub {
            return Given(method: .m_readZshVar__key_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func readBashVar(key: Parameter<String>, willReturn: String?...) -> MethodStub {
            return Given(method: .m_readBashVar__key_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func askQuestion(question: Parameter<String>, willReturn: String?...) -> MethodStub {
            return Given(method: .m_askQuestion__question_question(`question`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func askPermission(question: Parameter<String>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_askPermission__question_question(`question`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func bash(command: Parameter<String>, willProduce: (Stubber<String?>) -> Void) -> MethodStub {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .m_bash__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func bashWithExitCode(command: Parameter<String>, willProduce: (Stubber<Command?>) -> Void) -> MethodStub {
            let willReturn: [Command?] = []
			let given: Given = { return Given(method: .m_bashWithExitCode__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Command?).self)
			willProduce(stubber)
			return given
        }
        @discardableResult
		public static func runBash(command: Parameter<String>, willProduce: (Stubber<Int32?>) -> Void) -> MethodStub {
            let willReturn: [Int32?] = []
			let given: Given = { return Given(method: .m_runBash__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Int32?).self)
			willProduce(stubber)
			return given
        }
        public static func zsh(command: Parameter<String>, willProduce: (Stubber<String?>) -> Void) -> MethodStub {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .m_zsh__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func zshWithExitCode(command: Parameter<String>, willProduce: (Stubber<Command?>) -> Void) -> MethodStub {
            let willReturn: [Command?] = []
			let given: Given = { return Given(method: .m_zshWithExitCode__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Command?).self)
			willProduce(stubber)
			return given
        }
        @discardableResult
		public static func runZsh(command: Parameter<String>, willProduce: (Stubber<Int32?>) -> Void) -> MethodStub {
            let willReturn: [Int32?] = []
			let given: Given = { return Given(method: .m_runZsh__command_command(`command`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Int32?).self)
			willProduce(stubber)
			return given
        }
        public static func readZshVar(key: Parameter<String>, willProduce: (Stubber<String?>) -> Void) -> MethodStub {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .m_readZshVar__key_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func readBashVar(key: Parameter<String>, willProduce: (Stubber<String?>) -> Void) -> MethodStub {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .m_readBashVar__key_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func askQuestion(question: Parameter<String>, willProduce: (Stubber<String?>) -> Void) -> MethodStub {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .m_askQuestion__question_question(`question`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func askPermission(question: Parameter<String>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_askPermission__question_question(`question`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func bash(command: Parameter<String>) -> Verify { return Verify(method: .m_bash__command_command(`command`))}
        public static func bashWithExitCode(command: Parameter<String>) -> Verify { return Verify(method: .m_bashWithExitCode__command_command(`command`))}
        @discardableResult
		public static func runBash(command: Parameter<String>) -> Verify { return Verify(method: .m_runBash__command_command(`command`))}
        public static func zsh(command: Parameter<String>) -> Verify { return Verify(method: .m_zsh__command_command(`command`))}
        public static func zshWithExitCode(command: Parameter<String>) -> Verify { return Verify(method: .m_zshWithExitCode__command_command(`command`))}
        @discardableResult
		public static func runZsh(command: Parameter<String>) -> Verify { return Verify(method: .m_runZsh__command_command(`command`))}
        public static func readZshVar(key: Parameter<String>) -> Verify { return Verify(method: .m_readZshVar__key_key(`key`))}
        public static func readBashVar(key: Parameter<String>) -> Verify { return Verify(method: .m_readBashVar__key_key(`key`))}
        public static func askQuestion(question: Parameter<String>) -> Verify { return Verify(method: .m_askQuestion__question_question(`question`))}
        public static func askPermission(question: Parameter<String>) -> Verify { return Verify(method: .m_askPermission__question_question(`question`))}
        public static func print(color: Parameter<ANSIColors>, text: Parameter<String>) -> Verify { return Verify(method: .m_print__color_colortext_text(`color`, `text`))}
        public static func exit(with code: Parameter<Int32>) -> Verify { return Verify(method: .m_exit__with_code(`code`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func bash(command: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_bash__command_command(`command`), performs: perform)
        }
        public static func bashWithExitCode(command: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_bashWithExitCode__command_command(`command`), performs: perform)
        }
        @discardableResult
		public static func runBash(command: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_runBash__command_command(`command`), performs: perform)
        }
        public static func zsh(command: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_zsh__command_command(`command`), performs: perform)
        }
        public static func zshWithExitCode(command: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_zshWithExitCode__command_command(`command`), performs: perform)
        }
        @discardableResult
		public static func runZsh(command: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_runZsh__command_command(`command`), performs: perform)
        }
        public static func readZshVar(key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_readZshVar__key_key(`key`), performs: perform)
        }
        public static func readBashVar(key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_readBashVar__key_key(`key`), performs: perform)
        }
        public static func askQuestion(question: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_askQuestion__question_question(`question`), performs: perform)
        }
        public static func askPermission(question: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_askPermission__question_question(`question`), performs: perform)
        }
        public static func print(color: Parameter<ANSIColors>, text: Parameter<String>, perform: @escaping (ANSIColors, String) -> Void) -> Perform {
            return Perform(method: .m_print__color_colortext_text(`color`, `text`), performs: perform)
        }
        public static func exit(with code: Parameter<Int32>, perform: @escaping (Int32) -> Void) -> Perform {
            return Perform(method: .m_exit__with_code(`code`), performs: perform)
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
