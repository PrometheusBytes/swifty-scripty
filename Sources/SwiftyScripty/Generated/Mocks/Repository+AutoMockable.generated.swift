// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

public class RepositoryMock: Repository {

    public init() {}

    //MARK: - createFolder

    public var createFolderInsideNameDeleteIfExistsCallsCount = 0
    public var createFolderInsideNameDeleteIfExistsCalled: Bool {
        return createFolderInsideNameDeleteIfExistsCallsCount > 0
    }
    public var createFolderInsideNameDeleteIfExistsReceivedArguments: (folder: Folders, name: String, deleteIfExists: Bool)?
    public var createFolderInsideNameDeleteIfExistsReceivedInvocations: [(folder: Folders, name: String, deleteIfExists: Bool)] = []
    public var createFolderInsideNameDeleteIfExistsReturnValue: Bool!
    public var createFolderInsideNameDeleteIfExistsClosure: ((Folders, String, Bool) -> Bool)?

    public func createFolder(inside folder: Folders, name: String, deleteIfExists: Bool) -> Bool {
        createFolderInsideNameDeleteIfExistsCallsCount += 1
        createFolderInsideNameDeleteIfExistsReceivedArguments = (folder: folder, name: name, deleteIfExists: deleteIfExists)
        createFolderInsideNameDeleteIfExistsReceivedInvocations.append((folder: folder, name: name, deleteIfExists: deleteIfExists))
        return createFolderInsideNameDeleteIfExistsClosure.map({ $0(folder, name, deleteIfExists) }) ?? createFolderInsideNameDeleteIfExistsReturnValue
    }

    //MARK: - createFolder

    public var createFolderAtDeleteIfExistsCallsCount = 0
    public var createFolderAtDeleteIfExistsCalled: Bool {
        return createFolderAtDeleteIfExistsCallsCount > 0
    }
    public var createFolderAtDeleteIfExistsReceivedArguments: (path: URL?, deleteIfExists: Bool)?
    public var createFolderAtDeleteIfExistsReceivedInvocations: [(path: URL?, deleteIfExists: Bool)] = []
    public var createFolderAtDeleteIfExistsReturnValue: Bool!
    public var createFolderAtDeleteIfExistsClosure: ((URL?, Bool) -> Bool)?

    public func createFolder(at path: URL?, deleteIfExists: Bool) -> Bool {
        createFolderAtDeleteIfExistsCallsCount += 1
        createFolderAtDeleteIfExistsReceivedArguments = (path: path, deleteIfExists: deleteIfExists)
        createFolderAtDeleteIfExistsReceivedInvocations.append((path: path, deleteIfExists: deleteIfExists))
        return createFolderAtDeleteIfExistsClosure.map({ $0(path, deleteIfExists) }) ?? createFolderAtDeleteIfExistsReturnValue
    }

    //MARK: - delete

    public var deleteAtCallsCount = 0
    public var deleteAtCalled: Bool {
        return deleteAtCallsCount > 0
    }
    public var deleteAtReceivedPath: URL?
    public var deleteAtReceivedInvocations: [URL?] = []
    public var deleteAtReturnValue: Bool!
    public var deleteAtClosure: ((URL?) -> Bool)?

    public func delete(at path: URL?) -> Bool {
        deleteAtCallsCount += 1
        deleteAtReceivedPath = path
        deleteAtReceivedInvocations.append(path)
        return deleteAtClosure.map({ $0(path) }) ?? deleteAtReturnValue
    }

    //MARK: - deleteFile

    public var deleteFileAtNameCallsCount = 0
    public var deleteFileAtNameCalled: Bool {
        return deleteFileAtNameCallsCount > 0
    }
    public var deleteFileAtNameReceivedArguments: (path: URL?, name: String)?
    public var deleteFileAtNameReceivedInvocations: [(path: URL?, name: String)] = []
    public var deleteFileAtNameReturnValue: Bool!
    public var deleteFileAtNameClosure: ((URL?, String) -> Bool)?

    public func deleteFile(at path: URL?, name: String) -> Bool {
        deleteFileAtNameCallsCount += 1
        deleteFileAtNameReceivedArguments = (path: path, name: name)
        deleteFileAtNameReceivedInvocations.append((path: path, name: name))
        return deleteFileAtNameClosure.map({ $0(path, name) }) ?? deleteFileAtNameReturnValue
    }

    //MARK: - fileExists

    public var fileExistsAtCallsCount = 0
    public var fileExistsAtCalled: Bool {
        return fileExistsAtCallsCount > 0
    }
    public var fileExistsAtReceivedPath: URL?
    public var fileExistsAtReceivedInvocations: [URL?] = []
    public var fileExistsAtReturnValue: Bool!
    public var fileExistsAtClosure: ((URL?) -> Bool)?

    public func fileExists(at path: URL?) -> Bool {
        fileExistsAtCallsCount += 1
        fileExistsAtReceivedPath = path
        fileExistsAtReceivedInvocations.append(path)
        return fileExistsAtClosure.map({ $0(path) }) ?? fileExistsAtReturnValue
    }

    //MARK: - folderExists

    public var folderExistsAtCallsCount = 0
    public var folderExistsAtCalled: Bool {
        return folderExistsAtCallsCount > 0
    }
    public var folderExistsAtReceivedPath: URL?
    public var folderExistsAtReceivedInvocations: [URL?] = []
    public var folderExistsAtReturnValue: Bool!
    public var folderExistsAtClosure: ((URL?) -> Bool)?

    public func folderExists(at path: URL?) -> Bool {
        folderExistsAtCallsCount += 1
        folderExistsAtReceivedPath = path
        folderExistsAtReceivedInvocations.append(path)
        return folderExistsAtClosure.map({ $0(path) }) ?? folderExistsAtReturnValue
    }

    //MARK: - fileOrFolderExists

    public var fileOrFolderExistsAtCallsCount = 0
    public var fileOrFolderExistsAtCalled: Bool {
        return fileOrFolderExistsAtCallsCount > 0
    }
    public var fileOrFolderExistsAtReceivedPath: URL?
    public var fileOrFolderExistsAtReceivedInvocations: [URL?] = []
    public var fileOrFolderExistsAtReturnValue: Bool!
    public var fileOrFolderExistsAtClosure: ((URL?) -> Bool)?

    public func fileOrFolderExists(at path: URL?) -> Bool {
        fileOrFolderExistsAtCallsCount += 1
        fileOrFolderExistsAtReceivedPath = path
        fileOrFolderExistsAtReceivedInvocations.append(path)
        return fileOrFolderExistsAtClosure.map({ $0(path) }) ?? fileOrFolderExistsAtReturnValue
    }

    //MARK: - readFile

    public var readFileFromCallsCount = 0
    public var readFileFromCalled: Bool {
        return readFileFromCallsCount > 0
    }
    public var readFileFromReceivedPath: URL?
    public var readFileFromReceivedInvocations: [URL?] = []
    public var readFileFromReturnValue: String?
    public var readFileFromClosure: ((URL?) -> String?)?

    public func readFile(from path: URL?) -> String? {
        readFileFromCallsCount += 1
        readFileFromReceivedPath = path
        readFileFromReceivedInvocations.append(path)
        return readFileFromClosure.map({ $0(path) }) ?? readFileFromReturnValue
    }

    //MARK: - copyFile

    public var copyFileFromToCallsCount = 0
    public var copyFileFromToCalled: Bool {
        return copyFileFromToCallsCount > 0
    }
    public var copyFileFromToReceivedArguments: (originPath: URL?, destinationPath: URL?)?
    public var copyFileFromToReceivedInvocations: [(originPath: URL?, destinationPath: URL?)] = []
    public var copyFileFromToReturnValue: Bool!
    public var copyFileFromToClosure: ((URL?, URL?) -> Bool)?

    public func copyFile(from originPath: URL?, to destinationPath: URL?) -> Bool {
        copyFileFromToCallsCount += 1
        copyFileFromToReceivedArguments = (originPath: originPath, destinationPath: destinationPath)
        copyFileFromToReceivedInvocations.append((originPath: originPath, destinationPath: destinationPath))
        return copyFileFromToClosure.map({ $0(originPath, destinationPath) }) ?? copyFileFromToReturnValue
    }

    //MARK: - replaceFileContent

    public var replaceFileContentFromWithCallsCount = 0
    public var replaceFileContentFromWithCalled: Bool {
        return replaceFileContentFromWithCallsCount > 0
    }
    public var replaceFileContentFromWithReceivedArguments: (path: URL?, content: String)?
    public var replaceFileContentFromWithReceivedInvocations: [(path: URL?, content: String)] = []
    public var replaceFileContentFromWithReturnValue: Bool!
    public var replaceFileContentFromWithClosure: ((URL?, String) -> Bool)?

    public func replaceFileContent(from path: URL?, with content: String) -> Bool {
        replaceFileContentFromWithCallsCount += 1
        replaceFileContentFromWithReceivedArguments = (path: path, content: content)
        replaceFileContentFromWithReceivedInvocations.append((path: path, content: content))
        return replaceFileContentFromWithClosure.map({ $0(path, content) }) ?? replaceFileContentFromWithReturnValue
    }

    //MARK: - path

    public var pathOfCallsCount = 0
    public var pathOfCalled: Bool {
        return pathOfCallsCount > 0
    }
    public var pathOfReceivedFolder: Folders?
    public var pathOfReceivedInvocations: [Folders] = []
    public var pathOfReturnValue: URL?
    public var pathOfClosure: ((Folders) -> URL?)?

    public func path(of folder: Folders) -> URL? {
        pathOfCallsCount += 1
        pathOfReceivedFolder = folder
        pathOfReceivedInvocations.append(folder)
        return pathOfClosure.map({ $0(folder) }) ?? pathOfReturnValue
    }

    //MARK: - append

    public var appendFolderAtCallsCount = 0
    public var appendFolderAtCalled: Bool {
        return appendFolderAtCallsCount > 0
    }
    public var appendFolderAtReceivedArguments: (folder: String, rootFolder: Folders)?
    public var appendFolderAtReceivedInvocations: [(folder: String, rootFolder: Folders)] = []
    public var appendFolderAtReturnValue: URL?
    public var appendFolderAtClosure: ((String, Folders) -> URL?)?

    public func append(folder: String, at rootFolder: Folders) -> URL? {
        appendFolderAtCallsCount += 1
        appendFolderAtReceivedArguments = (folder: folder, rootFolder: rootFolder)
        appendFolderAtReceivedInvocations.append((folder: folder, rootFolder: rootFolder))
        return appendFolderAtClosure.map({ $0(folder, rootFolder) }) ?? appendFolderAtReturnValue
    }

    //MARK: - append

    public var appendFoldersAtCallsCount = 0
    public var appendFoldersAtCalled: Bool {
        return appendFoldersAtCallsCount > 0
    }
    public var appendFoldersAtReceivedArguments: (folders: [String], rootFolder: Folders)?
    public var appendFoldersAtReceivedInvocations: [(folders: [String], rootFolder: Folders)] = []
    public var appendFoldersAtReturnValue: URL?
    public var appendFoldersAtClosure: (([String], Folders) -> URL?)?

    public func append(folders: [String], at rootFolder: Folders) -> URL? {
        appendFoldersAtCallsCount += 1
        appendFoldersAtReceivedArguments = (folders: folders, rootFolder: rootFolder)
        appendFoldersAtReceivedInvocations.append((folders: folders, rootFolder: rootFolder))
        return appendFoldersAtClosure.map({ $0(folders, rootFolder) }) ?? appendFoldersAtReturnValue
    }

    //MARK: - append

    public var appendFolderAtURLCallsCount = 0
    public var appendFolderAtURLCalled: Bool {
        return appendFolderAtURLCallsCount > 0
    }
    public var appendFolderAtURLReceivedArguments: (folder: String, rootFolder: URL?)?
    public var appendFolderAtURLReceivedInvocations: [(folder: String, rootFolder: URL?)] = []
    public var appendFolderAtURLReturnValue: URL?
    public var appendFolderAtURLClosure: ((String, URL?) -> URL?)?

    public func append(folder: String, atURL rootFolder: URL?) -> URL? {
        appendFolderAtURLCallsCount += 1
        appendFolderAtURLReceivedArguments = (folder: folder, rootFolder: rootFolder)
        appendFolderAtURLReceivedInvocations.append((folder: folder, rootFolder: rootFolder))
        return appendFolderAtURLClosure.map({ $0(folder, rootFolder) }) ?? appendFolderAtURLReturnValue
    }

    //MARK: - append

    public var appendFoldersAtURLCallsCount = 0
    public var appendFoldersAtURLCalled: Bool {
        return appendFoldersAtURLCallsCount > 0
    }
    public var appendFoldersAtURLReceivedArguments: (folders: [String], rootFolder: URL?)?
    public var appendFoldersAtURLReceivedInvocations: [(folders: [String], rootFolder: URL?)] = []
    public var appendFoldersAtURLReturnValue: URL?
    public var appendFoldersAtURLClosure: (([String], URL?) -> URL?)?

    public func append(folders: [String], atURL rootFolder: URL?) -> URL? {
        appendFoldersAtURLCallsCount += 1
        appendFoldersAtURLReceivedArguments = (folders: folders, rootFolder: rootFolder)
        appendFoldersAtURLReceivedInvocations.append((folders: folders, rootFolder: rootFolder))
        return appendFoldersAtURLClosure.map({ $0(folders, rootFolder) }) ?? appendFoldersAtURLReturnValue
    }

    //MARK: - contentsOfDirectory

    public var contentsOfDirectoryAtURLThrowableError: Error?
    public var contentsOfDirectoryAtURLCallsCount = 0
    public var contentsOfDirectoryAtURLCalled: Bool {
        return contentsOfDirectoryAtURLCallsCount > 0
    }
    public var contentsOfDirectoryAtURLReceivedAtURL: URL?
    public var contentsOfDirectoryAtURLReceivedInvocations: [URL] = []
    public var contentsOfDirectoryAtURLReturnValue: [String]!
    public var contentsOfDirectoryAtURLClosure: ((URL) throws -> [String])?

    public func contentsOfDirectory(atURL: URL) throws -> [String] {
        if let error = contentsOfDirectoryAtURLThrowableError {
            throw error
        }
        contentsOfDirectoryAtURLCallsCount += 1
        contentsOfDirectoryAtURLReceivedAtURL = atURL
        contentsOfDirectoryAtURLReceivedInvocations.append(atURL)
        return try contentsOfDirectoryAtURLClosure.map({ try $0(atURL) }) ?? contentsOfDirectoryAtURLReturnValue
    }

}
