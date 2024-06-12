// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

public class FileUtilityMock: FileUtility {


    public init() {}

    //MARK: - folderExists

    public var folderExistsAtCallsCount = 0
    public var folderExistsAtCalled: Bool {
        return folderExistsAtCallsCount > 0
    }
    public var folderExistsAtReceivedPath: URL?
    public var folderExistsAtReceivedInvocations: [URL] = []
    public var folderExistsAtReturnValue: Bool!
    public var folderExistsAtClosure: ((URL) -> Bool)?

    public func folderExists(at path: URL) -> Bool {
        folderExistsAtCallsCount += 1
        folderExistsAtReceivedPath = path
        folderExistsAtReceivedInvocations.append(path)
        return folderExistsAtClosure.map({ $0(path) }) ?? folderExistsAtReturnValue
    }

    //MARK: - fileExists

    public var fileExistsAtCallsCount = 0
    public var fileExistsAtCalled: Bool {
        return fileExistsAtCallsCount > 0
    }
    public var fileExistsAtReceivedPath: URL?
    public var fileExistsAtReceivedInvocations: [URL] = []
    public var fileExistsAtReturnValue: Bool!
    public var fileExistsAtClosure: ((URL) -> Bool)?

    public func fileExists(at path: URL) -> Bool {
        fileExistsAtCallsCount += 1
        fileExistsAtReceivedPath = path
        fileExistsAtReceivedInvocations.append(path)
        return fileExistsAtClosure.map({ $0(path) }) ?? fileExistsAtReturnValue
    }

    //MARK: - fileOrFolderExists

    public var fileOrFolderExistsAtCallsCount = 0
    public var fileOrFolderExistsAtCalled: Bool {
        return fileOrFolderExistsAtCallsCount > 0
    }
    public var fileOrFolderExistsAtReceivedPath: URL?
    public var fileOrFolderExistsAtReceivedInvocations: [URL] = []
    public var fileOrFolderExistsAtReturnValue: Bool!
    public var fileOrFolderExistsAtClosure: ((URL) -> Bool)?

    public func fileOrFolderExists(at path: URL) -> Bool {
        fileOrFolderExistsAtCallsCount += 1
        fileOrFolderExistsAtReceivedPath = path
        fileOrFolderExistsAtReceivedInvocations.append(path)
        return fileOrFolderExistsAtClosure.map({ $0(path) }) ?? fileOrFolderExistsAtReturnValue
    }

    //MARK: - createFolder

    public var createFolderAtDeleteIfExistsCallsCount = 0
    public var createFolderAtDeleteIfExistsCalled: Bool {
        return createFolderAtDeleteIfExistsCallsCount > 0
    }
    public var createFolderAtDeleteIfExistsReceivedArguments: (path: URL, deleteIfExists: Bool)?
    public var createFolderAtDeleteIfExistsReceivedInvocations: [(path: URL, deleteIfExists: Bool)] = []
    public var createFolderAtDeleteIfExistsReturnValue: Bool!
    public var createFolderAtDeleteIfExistsClosure: ((URL, Bool) -> Bool)?

    public func createFolder(at path: URL, deleteIfExists: Bool) -> Bool {
        createFolderAtDeleteIfExistsCallsCount += 1
        createFolderAtDeleteIfExistsReceivedArguments = (path: path, deleteIfExists: deleteIfExists)
        createFolderAtDeleteIfExistsReceivedInvocations.append((path: path, deleteIfExists: deleteIfExists))
        return createFolderAtDeleteIfExistsClosure.map({ $0(path, deleteIfExists) }) ?? createFolderAtDeleteIfExistsReturnValue
    }

    //MARK: - deleteFile

    public var deleteFileAtCallsCount = 0
    public var deleteFileAtCalled: Bool {
        return deleteFileAtCallsCount > 0
    }
    public var deleteFileAtReceivedPath: URL?
    public var deleteFileAtReceivedInvocations: [URL] = []
    public var deleteFileAtReturnValue: Bool!
    public var deleteFileAtClosure: ((URL) -> Bool)?

    public func deleteFile(at path: URL) -> Bool {
        deleteFileAtCallsCount += 1
        deleteFileAtReceivedPath = path
        deleteFileAtReceivedInvocations.append(path)
        return deleteFileAtClosure.map({ $0(path) }) ?? deleteFileAtReturnValue
    }

    //MARK: - deleteFile

    public var deleteFileAtNameCallsCount = 0
    public var deleteFileAtNameCalled: Bool {
        return deleteFileAtNameCallsCount > 0
    }
    public var deleteFileAtNameReceivedArguments: (path: URL, name: String)?
    public var deleteFileAtNameReceivedInvocations: [(path: URL, name: String)] = []
    public var deleteFileAtNameReturnValue: Bool!
    public var deleteFileAtNameClosure: ((URL, String) -> Bool)?

    public func deleteFile(at path: URL, name: String) -> Bool {
        deleteFileAtNameCallsCount += 1
        deleteFileAtNameReceivedArguments = (path: path, name: name)
        deleteFileAtNameReceivedInvocations.append((path: path, name: name))
        return deleteFileAtNameClosure.map({ $0(path, name) }) ?? deleteFileAtNameReturnValue
    }

    //MARK: - copyFile

    public var copyFileFromToCallsCount = 0
    public var copyFileFromToCalled: Bool {
        return copyFileFromToCallsCount > 0
    }
    public var copyFileFromToReceivedArguments: (origin: URL, destination: URL)?
    public var copyFileFromToReceivedInvocations: [(origin: URL, destination: URL)] = []
    public var copyFileFromToReturnValue: Bool!
    public var copyFileFromToClosure: ((URL, URL) -> Bool)?

    public func copyFile(from origin: URL, to destination: URL) -> Bool {
        copyFileFromToCallsCount += 1
        copyFileFromToReceivedArguments = (origin: origin, destination: destination)
        copyFileFromToReceivedInvocations.append((origin: origin, destination: destination))
        return copyFileFromToClosure.map({ $0(origin, destination) }) ?? copyFileFromToReturnValue
    }

    //MARK: - readFile

    public var readFileAtCallsCount = 0
    public var readFileAtCalled: Bool {
        return readFileAtCallsCount > 0
    }
    public var readFileAtReceivedPath: URL?
    public var readFileAtReceivedInvocations: [URL] = []
    public var readFileAtReturnValue: String?
    public var readFileAtClosure: ((URL) -> String?)?

    public func readFile(at path: URL) -> String? {
        readFileAtCallsCount += 1
        readFileAtReceivedPath = path
        readFileAtReceivedInvocations.append(path)
        return readFileAtClosure.map({ $0(path) }) ?? readFileAtReturnValue
    }

    //MARK: - writeFile

    public var writeFileContentToCallsCount = 0
    public var writeFileContentToCalled: Bool {
        return writeFileContentToCallsCount > 0
    }
    public var writeFileContentToReceivedArguments: (content: String, path: URL)?
    public var writeFileContentToReceivedInvocations: [(content: String, path: URL)] = []
    public var writeFileContentToReturnValue: Bool!
    public var writeFileContentToClosure: ((String, URL) -> Bool)?

    public func writeFile(content: String, to path: URL) -> Bool {
        writeFileContentToCallsCount += 1
        writeFileContentToReceivedArguments = (content: content, path: path)
        writeFileContentToReceivedInvocations.append((content: content, path: path))
        return writeFileContentToClosure.map({ $0(content, path) }) ?? writeFileContentToReturnValue
    }

}
