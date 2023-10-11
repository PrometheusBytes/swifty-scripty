// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: SwiftLint rules
//swiftlint:disable all

// MARK: Imports

import SwiftyMocky
import XCTest
import Foundation
import SwiftyScripty
// MARK: - Repository

open class RepositoryMock: Repository, Mock {
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





    open func createFolder(inside folder: Folders, name: String, deleteIfExists: Bool) -> Bool {
        addInvocation(.m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(Parameter<Folders>.value(`folder`), Parameter<String>.value(`name`), Parameter<Bool>.value(`deleteIfExists`)))
		let perform = methodPerformValue(.m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(Parameter<Folders>.value(`folder`), Parameter<String>.value(`name`), Parameter<Bool>.value(`deleteIfExists`))) as? (Folders, String, Bool) -> Void
		perform?(`folder`, `name`, `deleteIfExists`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(Parameter<Folders>.value(`folder`), Parameter<String>.value(`name`), Parameter<Bool>.value(`deleteIfExists`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createFolder(inside folder: Folders, name: String, deleteIfExists: Bool). Use given")
			Failure("Stub return value not specified for createFolder(inside folder: Folders, name: String, deleteIfExists: Bool). Use given")
		}
		return __value
    }

    open func createFolder(at path: URL?, deleteIfExists: Bool) -> Bool {
        addInvocation(.m_createFolder__at_pathdeleteIfExists_deleteIfExists(Parameter<URL?>.value(`path`), Parameter<Bool>.value(`deleteIfExists`)))
		let perform = methodPerformValue(.m_createFolder__at_pathdeleteIfExists_deleteIfExists(Parameter<URL?>.value(`path`), Parameter<Bool>.value(`deleteIfExists`))) as? (URL?, Bool) -> Void
		perform?(`path`, `deleteIfExists`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_createFolder__at_pathdeleteIfExists_deleteIfExists(Parameter<URL?>.value(`path`), Parameter<Bool>.value(`deleteIfExists`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createFolder(at path: URL?, deleteIfExists: Bool). Use given")
			Failure("Stub return value not specified for createFolder(at path: URL?, deleteIfExists: Bool). Use given")
		}
		return __value
    }

    @discardableResult
	open func delete(at path: URL?) -> Bool {
        addInvocation(.m_delete__at_path(Parameter<URL?>.value(`path`)))
		let perform = methodPerformValue(.m_delete__at_path(Parameter<URL?>.value(`path`))) as? (URL?) -> Void
		perform?(`path`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_delete__at_path(Parameter<URL?>.value(`path`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for delete(at path: URL?). Use given")
			Failure("Stub return value not specified for delete(at path: URL?). Use given")
		}
		return __value
    }

    @discardableResult
	open func deleteFile(at path: URL?, name: String) -> Bool {
        addInvocation(.m_deleteFile__at_pathname_name(Parameter<URL?>.value(`path`), Parameter<String>.value(`name`)))
		let perform = methodPerformValue(.m_deleteFile__at_pathname_name(Parameter<URL?>.value(`path`), Parameter<String>.value(`name`))) as? (URL?, String) -> Void
		perform?(`path`, `name`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_deleteFile__at_pathname_name(Parameter<URL?>.value(`path`), Parameter<String>.value(`name`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for deleteFile(at path: URL?, name: String). Use given")
			Failure("Stub return value not specified for deleteFile(at path: URL?, name: String). Use given")
		}
		return __value
    }

    open func fileExists(at path: URL?) -> Bool {
        addInvocation(.m_fileExists__at_path(Parameter<URL?>.value(`path`)))
		let perform = methodPerformValue(.m_fileExists__at_path(Parameter<URL?>.value(`path`))) as? (URL?) -> Void
		perform?(`path`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_fileExists__at_path(Parameter<URL?>.value(`path`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fileExists(at path: URL?). Use given")
			Failure("Stub return value not specified for fileExists(at path: URL?). Use given")
		}
		return __value
    }

    open func folderExists(at path: URL?) -> Bool {
        addInvocation(.m_folderExists__at_path(Parameter<URL?>.value(`path`)))
		let perform = methodPerformValue(.m_folderExists__at_path(Parameter<URL?>.value(`path`))) as? (URL?) -> Void
		perform?(`path`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_folderExists__at_path(Parameter<URL?>.value(`path`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for folderExists(at path: URL?). Use given")
			Failure("Stub return value not specified for folderExists(at path: URL?). Use given")
		}
		return __value
    }

    open func fileOrFolderExists(at path: URL?) -> Bool {
        addInvocation(.m_fileOrFolderExists__at_path(Parameter<URL?>.value(`path`)))
		let perform = methodPerformValue(.m_fileOrFolderExists__at_path(Parameter<URL?>.value(`path`))) as? (URL?) -> Void
		perform?(`path`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_fileOrFolderExists__at_path(Parameter<URL?>.value(`path`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fileOrFolderExists(at path: URL?). Use given")
			Failure("Stub return value not specified for fileOrFolderExists(at path: URL?). Use given")
		}
		return __value
    }

    open func readFile(from path: URL?) -> String? {
        addInvocation(.m_readFile__from_path(Parameter<URL?>.value(`path`)))
		let perform = methodPerformValue(.m_readFile__from_path(Parameter<URL?>.value(`path`))) as? (URL?) -> Void
		perform?(`path`)
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_readFile__from_path(Parameter<URL?>.value(`path`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func copyFile(from originPath: URL?, to destinationPath: URL?) -> Bool {
        addInvocation(.m_copyFile__from_originPathto_destinationPath(Parameter<URL?>.value(`originPath`), Parameter<URL?>.value(`destinationPath`)))
		let perform = methodPerformValue(.m_copyFile__from_originPathto_destinationPath(Parameter<URL?>.value(`originPath`), Parameter<URL?>.value(`destinationPath`))) as? (URL?, URL?) -> Void
		perform?(`originPath`, `destinationPath`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_copyFile__from_originPathto_destinationPath(Parameter<URL?>.value(`originPath`), Parameter<URL?>.value(`destinationPath`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for copyFile(from originPath: URL?, to destinationPath: URL?). Use given")
			Failure("Stub return value not specified for copyFile(from originPath: URL?, to destinationPath: URL?). Use given")
		}
		return __value
    }

    open func replaceFileContent(from path: URL?, with content: String) -> Bool {
        addInvocation(.m_replaceFileContent__from_pathwith_content(Parameter<URL?>.value(`path`), Parameter<String>.value(`content`)))
		let perform = methodPerformValue(.m_replaceFileContent__from_pathwith_content(Parameter<URL?>.value(`path`), Parameter<String>.value(`content`))) as? (URL?, String) -> Void
		perform?(`path`, `content`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_replaceFileContent__from_pathwith_content(Parameter<URL?>.value(`path`), Parameter<String>.value(`content`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for replaceFileContent(from path: URL?, with content: String). Use given")
			Failure("Stub return value not specified for replaceFileContent(from path: URL?, with content: String). Use given")
		}
		return __value
    }

    open func path(of folder: Folders) -> URL? {
        addInvocation(.m_path__of_folder(Parameter<Folders>.value(`folder`)))
		let perform = methodPerformValue(.m_path__of_folder(Parameter<Folders>.value(`folder`))) as? (Folders) -> Void
		perform?(`folder`)
		var __value: URL? = nil
		do {
		    __value = try methodReturnValue(.m_path__of_folder(Parameter<Folders>.value(`folder`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func append(folder: String, at rootFolder: Folders) -> URL? {
        addInvocation(.m_append__folder_folderat_rootFolder_1(Parameter<String>.value(`folder`), Parameter<Folders>.value(`rootFolder`)))
		let perform = methodPerformValue(.m_append__folder_folderat_rootFolder_1(Parameter<String>.value(`folder`), Parameter<Folders>.value(`rootFolder`))) as? (String, Folders) -> Void
		perform?(`folder`, `rootFolder`)
		var __value: URL? = nil
		do {
		    __value = try methodReturnValue(.m_append__folder_folderat_rootFolder_1(Parameter<String>.value(`folder`), Parameter<Folders>.value(`rootFolder`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func append(folders: [String], at rootFolder: Folders) -> URL? {
        addInvocation(.m_append__folders_foldersat_rootFolder_1(Parameter<[String]>.value(`folders`), Parameter<Folders>.value(`rootFolder`)))
		let perform = methodPerformValue(.m_append__folders_foldersat_rootFolder_1(Parameter<[String]>.value(`folders`), Parameter<Folders>.value(`rootFolder`))) as? ([String], Folders) -> Void
		perform?(`folders`, `rootFolder`)
		var __value: URL? = nil
		do {
		    __value = try methodReturnValue(.m_append__folders_foldersat_rootFolder_1(Parameter<[String]>.value(`folders`), Parameter<Folders>.value(`rootFolder`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func append(folder: String, at rootFolder: URL?) -> URL? {
        addInvocation(.m_append__folder_folderat_rootFolder_2(Parameter<String>.value(`folder`), Parameter<URL?>.value(`rootFolder`)))
		let perform = methodPerformValue(.m_append__folder_folderat_rootFolder_2(Parameter<String>.value(`folder`), Parameter<URL?>.value(`rootFolder`))) as? (String, URL?) -> Void
		perform?(`folder`, `rootFolder`)
		var __value: URL? = nil
		do {
		    __value = try methodReturnValue(.m_append__folder_folderat_rootFolder_2(Parameter<String>.value(`folder`), Parameter<URL?>.value(`rootFolder`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func append(folders: [String], at rootFolder: URL?) -> URL? {
        addInvocation(.m_append__folders_foldersat_rootFolder_2(Parameter<[String]>.value(`folders`), Parameter<URL?>.value(`rootFolder`)))
		let perform = methodPerformValue(.m_append__folders_foldersat_rootFolder_2(Parameter<[String]>.value(`folders`), Parameter<URL?>.value(`rootFolder`))) as? ([String], URL?) -> Void
		perform?(`folders`, `rootFolder`)
		var __value: URL? = nil
		do {
		    __value = try methodReturnValue(.m_append__folders_foldersat_rootFolder_2(Parameter<[String]>.value(`folders`), Parameter<URL?>.value(`rootFolder`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func contentsOfDirectory(atURL: URL) throws -> [String] {
        addInvocation(.m_contentsOfDirectory__atURL_atURL(Parameter<URL>.value(`atURL`)))
		let perform = methodPerformValue(.m_contentsOfDirectory__atURL_atURL(Parameter<URL>.value(`atURL`))) as? (URL) -> Void
		perform?(`atURL`)
		var __value: [String]
		do {
		    __value = try methodReturnValue(.m_contentsOfDirectory__atURL_atURL(Parameter<URL>.value(`atURL`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for contentsOfDirectory(atURL: URL). Use given")
			Failure("Stub return value not specified for contentsOfDirectory(atURL: URL). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(Parameter<Folders>, Parameter<String>, Parameter<Bool>)
        case m_createFolder__at_pathdeleteIfExists_deleteIfExists(Parameter<URL?>, Parameter<Bool>)
        case m_delete__at_path(Parameter<URL?>)
        case m_deleteFile__at_pathname_name(Parameter<URL?>, Parameter<String>)
        case m_fileExists__at_path(Parameter<URL?>)
        case m_folderExists__at_path(Parameter<URL?>)
        case m_fileOrFolderExists__at_path(Parameter<URL?>)
        case m_readFile__from_path(Parameter<URL?>)
        case m_copyFile__from_originPathto_destinationPath(Parameter<URL?>, Parameter<URL?>)
        case m_replaceFileContent__from_pathwith_content(Parameter<URL?>, Parameter<String>)
        case m_path__of_folder(Parameter<Folders>)
        case m_append__folder_folderat_rootFolder_1(Parameter<String>, Parameter<Folders>)
        case m_append__folders_foldersat_rootFolder_1(Parameter<[String]>, Parameter<Folders>)
        case m_append__folder_folderat_rootFolder_2(Parameter<String>, Parameter<URL?>)
        case m_append__folders_foldersat_rootFolder_2(Parameter<[String]>, Parameter<URL?>)
        case m_contentsOfDirectory__atURL_atURL(Parameter<URL>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(let lhsFolder, let lhsName, let lhsDeleteifexists), .m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(let rhsFolder, let rhsName, let rhsDeleteifexists)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFolder, rhs: rhsFolder, with: matcher), lhsFolder, rhsFolder, "inside folder"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher), lhsName, rhsName, "name"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDeleteifexists, rhs: rhsDeleteifexists, with: matcher), lhsDeleteifexists, rhsDeleteifexists, "deleteIfExists"))
				return Matcher.ComparisonResult(results)

            case (.m_createFolder__at_pathdeleteIfExists_deleteIfExists(let lhsPath, let lhsDeleteifexists), .m_createFolder__at_pathdeleteIfExists_deleteIfExists(let rhsPath, let rhsDeleteifexists)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "at path"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDeleteifexists, rhs: rhsDeleteifexists, with: matcher), lhsDeleteifexists, rhsDeleteifexists, "deleteIfExists"))
				return Matcher.ComparisonResult(results)

            case (.m_delete__at_path(let lhsPath), .m_delete__at_path(let rhsPath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "at path"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteFile__at_pathname_name(let lhsPath, let lhsName), .m_deleteFile__at_pathname_name(let rhsPath, let rhsName)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "at path"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher), lhsName, rhsName, "name"))
				return Matcher.ComparisonResult(results)

            case (.m_fileExists__at_path(let lhsPath), .m_fileExists__at_path(let rhsPath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "at path"))
				return Matcher.ComparisonResult(results)

            case (.m_folderExists__at_path(let lhsPath), .m_folderExists__at_path(let rhsPath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "at path"))
				return Matcher.ComparisonResult(results)

            case (.m_fileOrFolderExists__at_path(let lhsPath), .m_fileOrFolderExists__at_path(let rhsPath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "at path"))
				return Matcher.ComparisonResult(results)

            case (.m_readFile__from_path(let lhsPath), .m_readFile__from_path(let rhsPath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "from path"))
				return Matcher.ComparisonResult(results)

            case (.m_copyFile__from_originPathto_destinationPath(let lhsOriginpath, let lhsDestinationpath), .m_copyFile__from_originPathto_destinationPath(let rhsOriginpath, let rhsDestinationpath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOriginpath, rhs: rhsOriginpath, with: matcher), lhsOriginpath, rhsOriginpath, "from originPath"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestinationpath, rhs: rhsDestinationpath, with: matcher), lhsDestinationpath, rhsDestinationpath, "to destinationPath"))
				return Matcher.ComparisonResult(results)

            case (.m_replaceFileContent__from_pathwith_content(let lhsPath, let lhsContent), .m_replaceFileContent__from_pathwith_content(let rhsPath, let rhsContent)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "from path"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsContent, rhs: rhsContent, with: matcher), lhsContent, rhsContent, "with content"))
				return Matcher.ComparisonResult(results)

            case (.m_path__of_folder(let lhsFolder), .m_path__of_folder(let rhsFolder)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFolder, rhs: rhsFolder, with: matcher), lhsFolder, rhsFolder, "of folder"))
				return Matcher.ComparisonResult(results)

            case (.m_append__folder_folderat_rootFolder_1(let lhsFolder, let lhsRootfolder), .m_append__folder_folderat_rootFolder_1(let rhsFolder, let rhsRootfolder)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFolder, rhs: rhsFolder, with: matcher), lhsFolder, rhsFolder, "folder"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRootfolder, rhs: rhsRootfolder, with: matcher), lhsRootfolder, rhsRootfolder, "at rootFolder"))
				return Matcher.ComparisonResult(results)

            case (.m_append__folders_foldersat_rootFolder_1(let lhsFolders, let lhsRootfolder), .m_append__folders_foldersat_rootFolder_1(let rhsFolders, let rhsRootfolder)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFolders, rhs: rhsFolders, with: matcher), lhsFolders, rhsFolders, "folders"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRootfolder, rhs: rhsRootfolder, with: matcher), lhsRootfolder, rhsRootfolder, "at rootFolder"))
				return Matcher.ComparisonResult(results)

            case (.m_append__folder_folderat_rootFolder_2(let lhsFolder, let lhsRootfolder), .m_append__folder_folderat_rootFolder_2(let rhsFolder, let rhsRootfolder)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFolder, rhs: rhsFolder, with: matcher), lhsFolder, rhsFolder, "folder"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRootfolder, rhs: rhsRootfolder, with: matcher), lhsRootfolder, rhsRootfolder, "at rootFolder"))
				return Matcher.ComparisonResult(results)

            case (.m_append__folders_foldersat_rootFolder_2(let lhsFolders, let lhsRootfolder), .m_append__folders_foldersat_rootFolder_2(let rhsFolders, let rhsRootfolder)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFolders, rhs: rhsFolders, with: matcher), lhsFolders, rhsFolders, "folders"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRootfolder, rhs: rhsRootfolder, with: matcher), lhsRootfolder, rhsRootfolder, "at rootFolder"))
				return Matcher.ComparisonResult(results)

            case (.m_contentsOfDirectory__atURL_atURL(let lhsAturl), .m_contentsOfDirectory__atURL_atURL(let rhsAturl)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAturl, rhs: rhsAturl, with: matcher), lhsAturl, rhsAturl, "atURL"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_createFolder__at_pathdeleteIfExists_deleteIfExists(p0, p1): return p0.intValue + p1.intValue
            case let .m_delete__at_path(p0): return p0.intValue
            case let .m_deleteFile__at_pathname_name(p0, p1): return p0.intValue + p1.intValue
            case let .m_fileExists__at_path(p0): return p0.intValue
            case let .m_folderExists__at_path(p0): return p0.intValue
            case let .m_fileOrFolderExists__at_path(p0): return p0.intValue
            case let .m_readFile__from_path(p0): return p0.intValue
            case let .m_copyFile__from_originPathto_destinationPath(p0, p1): return p0.intValue + p1.intValue
            case let .m_replaceFileContent__from_pathwith_content(p0, p1): return p0.intValue + p1.intValue
            case let .m_path__of_folder(p0): return p0.intValue
            case let .m_append__folder_folderat_rootFolder_1(p0, p1): return p0.intValue + p1.intValue
            case let .m_append__folders_foldersat_rootFolder_1(p0, p1): return p0.intValue + p1.intValue
            case let .m_append__folder_folderat_rootFolder_2(p0, p1): return p0.intValue + p1.intValue
            case let .m_append__folders_foldersat_rootFolder_2(p0, p1): return p0.intValue + p1.intValue
            case let .m_contentsOfDirectory__atURL_atURL(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists: return ".createFolder(inside:name:deleteIfExists:)"
            case .m_createFolder__at_pathdeleteIfExists_deleteIfExists: return ".createFolder(at:deleteIfExists:)"
            case .m_delete__at_path: return ".delete(at:)"
            case .m_deleteFile__at_pathname_name: return ".deleteFile(at:name:)"
            case .m_fileExists__at_path: return ".fileExists(at:)"
            case .m_folderExists__at_path: return ".folderExists(at:)"
            case .m_fileOrFolderExists__at_path: return ".fileOrFolderExists(at:)"
            case .m_readFile__from_path: return ".readFile(from:)"
            case .m_copyFile__from_originPathto_destinationPath: return ".copyFile(from:to:)"
            case .m_replaceFileContent__from_pathwith_content: return ".replaceFileContent(from:with:)"
            case .m_path__of_folder: return ".path(of:)"
            case .m_append__folder_folderat_rootFolder_1: return ".append(folder:at:)"
            case .m_append__folders_foldersat_rootFolder_1: return ".append(folders:at:)"
            case .m_append__folder_folderat_rootFolder_2: return ".append(folder:at:)"
            case .m_append__folders_foldersat_rootFolder_2: return ".append(folders:at:)"
            case .m_contentsOfDirectory__atURL_atURL: return ".contentsOfDirectory(atURL:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func createFolder(inside folder: Parameter<Folders>, name: Parameter<String>, deleteIfExists: Parameter<Bool>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(`folder`, `name`, `deleteIfExists`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createFolder(at path: Parameter<URL?>, deleteIfExists: Parameter<Bool>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_createFolder__at_pathdeleteIfExists_deleteIfExists(`path`, `deleteIfExists`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        @discardableResult
		public static func delete(at path: Parameter<URL?>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_delete__at_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        @discardableResult
		public static func deleteFile(at path: Parameter<URL?>, name: Parameter<String>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_deleteFile__at_pathname_name(`path`, `name`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fileExists(at path: Parameter<URL?>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_fileExists__at_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func folderExists(at path: Parameter<URL?>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_folderExists__at_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fileOrFolderExists(at path: Parameter<URL?>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_fileOrFolderExists__at_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func readFile(from path: Parameter<URL?>, willReturn: String?...) -> MethodStub {
            return Given(method: .m_readFile__from_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func copyFile(from originPath: Parameter<URL?>, to destinationPath: Parameter<URL?>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_copyFile__from_originPathto_destinationPath(`originPath`, `destinationPath`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func replaceFileContent(from path: Parameter<URL?>, with content: Parameter<String>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_replaceFileContent__from_pathwith_content(`path`, `content`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func path(of folder: Parameter<Folders>, willReturn: URL?...) -> MethodStub {
            return Given(method: .m_path__of_folder(`folder`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func append(folder: Parameter<String>, at rootFolder: Parameter<Folders>, willReturn: URL?...) -> MethodStub {
            return Given(method: .m_append__folder_folderat_rootFolder_1(`folder`, `rootFolder`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func append(folders: Parameter<[String]>, at rootFolder: Parameter<Folders>, willReturn: URL?...) -> MethodStub {
            return Given(method: .m_append__folders_foldersat_rootFolder_1(`folders`, `rootFolder`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func append(folder: Parameter<String>, at rootFolder: Parameter<URL?>, willReturn: URL?...) -> MethodStub {
            return Given(method: .m_append__folder_folderat_rootFolder_2(`folder`, `rootFolder`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func append(folders: Parameter<[String]>, at rootFolder: Parameter<URL?>, willReturn: URL?...) -> MethodStub {
            return Given(method: .m_append__folders_foldersat_rootFolder_2(`folders`, `rootFolder`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func contentsOfDirectory(atURL: Parameter<URL>, willReturn: [String]...) -> MethodStub {
            return Given(method: .m_contentsOfDirectory__atURL_atURL(`atURL`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createFolder(inside folder: Parameter<Folders>, name: Parameter<String>, deleteIfExists: Parameter<Bool>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(`folder`, `name`, `deleteIfExists`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func createFolder(at path: Parameter<URL?>, deleteIfExists: Parameter<Bool>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_createFolder__at_pathdeleteIfExists_deleteIfExists(`path`, `deleteIfExists`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        @discardableResult
		public static func delete(at path: Parameter<URL?>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_delete__at_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        @discardableResult
		public static func deleteFile(at path: Parameter<URL?>, name: Parameter<String>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_deleteFile__at_pathname_name(`path`, `name`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func fileExists(at path: Parameter<URL?>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_fileExists__at_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func folderExists(at path: Parameter<URL?>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_folderExists__at_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func fileOrFolderExists(at path: Parameter<URL?>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_fileOrFolderExists__at_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func readFile(from path: Parameter<URL?>, willProduce: (Stubber<String?>) -> Void) -> MethodStub {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .m_readFile__from_path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func copyFile(from originPath: Parameter<URL?>, to destinationPath: Parameter<URL?>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_copyFile__from_originPathto_destinationPath(`originPath`, `destinationPath`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func replaceFileContent(from path: Parameter<URL?>, with content: Parameter<String>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_replaceFileContent__from_pathwith_content(`path`, `content`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func path(of folder: Parameter<Folders>, willProduce: (Stubber<URL?>) -> Void) -> MethodStub {
            let willReturn: [URL?] = []
			let given: Given = { return Given(method: .m_path__of_folder(`folder`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URL?).self)
			willProduce(stubber)
			return given
        }
        public static func append(folder: Parameter<String>, at rootFolder: Parameter<Folders>, willProduce: (Stubber<URL?>) -> Void) -> MethodStub {
            let willReturn: [URL?] = []
			let given: Given = { return Given(method: .m_append__folder_folderat_rootFolder_1(`folder`, `rootFolder`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URL?).self)
			willProduce(stubber)
			return given
        }
        public static func append(folders: Parameter<[String]>, at rootFolder: Parameter<Folders>, willProduce: (Stubber<URL?>) -> Void) -> MethodStub {
            let willReturn: [URL?] = []
			let given: Given = { return Given(method: .m_append__folders_foldersat_rootFolder_1(`folders`, `rootFolder`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URL?).self)
			willProduce(stubber)
			return given
        }
        public static func append(folder: Parameter<String>, at rootFolder: Parameter<URL?>, willProduce: (Stubber<URL?>) -> Void) -> MethodStub {
            let willReturn: [URL?] = []
			let given: Given = { return Given(method: .m_append__folder_folderat_rootFolder_2(`folder`, `rootFolder`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URL?).self)
			willProduce(stubber)
			return given
        }
        public static func append(folders: Parameter<[String]>, at rootFolder: Parameter<URL?>, willProduce: (Stubber<URL?>) -> Void) -> MethodStub {
            let willReturn: [URL?] = []
			let given: Given = { return Given(method: .m_append__folders_foldersat_rootFolder_2(`folders`, `rootFolder`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URL?).self)
			willProduce(stubber)
			return given
        }
        public static func contentsOfDirectory(atURL: Parameter<URL>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_contentsOfDirectory__atURL_atURL(`atURL`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func contentsOfDirectory(atURL: Parameter<URL>, willProduce: (StubberThrows<[String]>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_contentsOfDirectory__atURL_atURL(`atURL`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: ([String]).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createFolder(inside folder: Parameter<Folders>, name: Parameter<String>, deleteIfExists: Parameter<Bool>) -> Verify { return Verify(method: .m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(`folder`, `name`, `deleteIfExists`))}
        public static func createFolder(at path: Parameter<URL?>, deleteIfExists: Parameter<Bool>) -> Verify { return Verify(method: .m_createFolder__at_pathdeleteIfExists_deleteIfExists(`path`, `deleteIfExists`))}
        @discardableResult
		public static func delete(at path: Parameter<URL?>) -> Verify { return Verify(method: .m_delete__at_path(`path`))}
        @discardableResult
		public static func deleteFile(at path: Parameter<URL?>, name: Parameter<String>) -> Verify { return Verify(method: .m_deleteFile__at_pathname_name(`path`, `name`))}
        public static func fileExists(at path: Parameter<URL?>) -> Verify { return Verify(method: .m_fileExists__at_path(`path`))}
        public static func folderExists(at path: Parameter<URL?>) -> Verify { return Verify(method: .m_folderExists__at_path(`path`))}
        public static func fileOrFolderExists(at path: Parameter<URL?>) -> Verify { return Verify(method: .m_fileOrFolderExists__at_path(`path`))}
        public static func readFile(from path: Parameter<URL?>) -> Verify { return Verify(method: .m_readFile__from_path(`path`))}
        public static func copyFile(from originPath: Parameter<URL?>, to destinationPath: Parameter<URL?>) -> Verify { return Verify(method: .m_copyFile__from_originPathto_destinationPath(`originPath`, `destinationPath`))}
        public static func replaceFileContent(from path: Parameter<URL?>, with content: Parameter<String>) -> Verify { return Verify(method: .m_replaceFileContent__from_pathwith_content(`path`, `content`))}
        public static func path(of folder: Parameter<Folders>) -> Verify { return Verify(method: .m_path__of_folder(`folder`))}
        public static func append(folder: Parameter<String>, at rootFolder: Parameter<Folders>) -> Verify { return Verify(method: .m_append__folder_folderat_rootFolder_1(`folder`, `rootFolder`))}
        public static func append(folders: Parameter<[String]>, at rootFolder: Parameter<Folders>) -> Verify { return Verify(method: .m_append__folders_foldersat_rootFolder_1(`folders`, `rootFolder`))}
        public static func append(folder: Parameter<String>, at rootFolder: Parameter<URL?>) -> Verify { return Verify(method: .m_append__folder_folderat_rootFolder_2(`folder`, `rootFolder`))}
        public static func append(folders: Parameter<[String]>, at rootFolder: Parameter<URL?>) -> Verify { return Verify(method: .m_append__folders_foldersat_rootFolder_2(`folders`, `rootFolder`))}
        public static func contentsOfDirectory(atURL: Parameter<URL>) -> Verify { return Verify(method: .m_contentsOfDirectory__atURL_atURL(`atURL`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createFolder(inside folder: Parameter<Folders>, name: Parameter<String>, deleteIfExists: Parameter<Bool>, perform: @escaping (Folders, String, Bool) -> Void) -> Perform {
            return Perform(method: .m_createFolder__inside_foldername_namedeleteIfExists_deleteIfExists(`folder`, `name`, `deleteIfExists`), performs: perform)
        }
        public static func createFolder(at path: Parameter<URL?>, deleteIfExists: Parameter<Bool>, perform: @escaping (URL?, Bool) -> Void) -> Perform {
            return Perform(method: .m_createFolder__at_pathdeleteIfExists_deleteIfExists(`path`, `deleteIfExists`), performs: perform)
        }
        @discardableResult
		public static func delete(at path: Parameter<URL?>, perform: @escaping (URL?) -> Void) -> Perform {
            return Perform(method: .m_delete__at_path(`path`), performs: perform)
        }
        @discardableResult
		public static func deleteFile(at path: Parameter<URL?>, name: Parameter<String>, perform: @escaping (URL?, String) -> Void) -> Perform {
            return Perform(method: .m_deleteFile__at_pathname_name(`path`, `name`), performs: perform)
        }
        public static func fileExists(at path: Parameter<URL?>, perform: @escaping (URL?) -> Void) -> Perform {
            return Perform(method: .m_fileExists__at_path(`path`), performs: perform)
        }
        public static func folderExists(at path: Parameter<URL?>, perform: @escaping (URL?) -> Void) -> Perform {
            return Perform(method: .m_folderExists__at_path(`path`), performs: perform)
        }
        public static func fileOrFolderExists(at path: Parameter<URL?>, perform: @escaping (URL?) -> Void) -> Perform {
            return Perform(method: .m_fileOrFolderExists__at_path(`path`), performs: perform)
        }
        public static func readFile(from path: Parameter<URL?>, perform: @escaping (URL?) -> Void) -> Perform {
            return Perform(method: .m_readFile__from_path(`path`), performs: perform)
        }
        public static func copyFile(from originPath: Parameter<URL?>, to destinationPath: Parameter<URL?>, perform: @escaping (URL?, URL?) -> Void) -> Perform {
            return Perform(method: .m_copyFile__from_originPathto_destinationPath(`originPath`, `destinationPath`), performs: perform)
        }
        public static func replaceFileContent(from path: Parameter<URL?>, with content: Parameter<String>, perform: @escaping (URL?, String) -> Void) -> Perform {
            return Perform(method: .m_replaceFileContent__from_pathwith_content(`path`, `content`), performs: perform)
        }
        public static func path(of folder: Parameter<Folders>, perform: @escaping (Folders) -> Void) -> Perform {
            return Perform(method: .m_path__of_folder(`folder`), performs: perform)
        }
        public static func append(folder: Parameter<String>, at rootFolder: Parameter<Folders>, perform: @escaping (String, Folders) -> Void) -> Perform {
            return Perform(method: .m_append__folder_folderat_rootFolder_1(`folder`, `rootFolder`), performs: perform)
        }
        public static func append(folders: Parameter<[String]>, at rootFolder: Parameter<Folders>, perform: @escaping ([String], Folders) -> Void) -> Perform {
            return Perform(method: .m_append__folders_foldersat_rootFolder_1(`folders`, `rootFolder`), performs: perform)
        }
        public static func append(folder: Parameter<String>, at rootFolder: Parameter<URL?>, perform: @escaping (String, URL?) -> Void) -> Perform {
            return Perform(method: .m_append__folder_folderat_rootFolder_2(`folder`, `rootFolder`), performs: perform)
        }
        public static func append(folders: Parameter<[String]>, at rootFolder: Parameter<URL?>, perform: @escaping ([String], URL?) -> Void) -> Perform {
            return Perform(method: .m_append__folders_foldersat_rootFolder_2(`folders`, `rootFolder`), performs: perform)
        }
        public static func contentsOfDirectory(atURL: Parameter<URL>, perform: @escaping (URL) -> Void) -> Perform {
            return Perform(method: .m_contentsOfDirectory__atURL_atURL(`atURL`), performs: perform)
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
