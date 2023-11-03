import Foundation

//sourcery: AutoMockable
public protocol Repository {
    func createFolder(inside folder: Folders, name: String, deleteIfExists: Bool) -> Bool
    func createFolder(at path: URL?, deleteIfExists: Bool) -> Bool
    @discardableResult func delete(at path: URL?) -> Bool
    @discardableResult func deleteFile(at path: URL?, name: String) -> Bool
    func fileExists(at path: URL?) -> Bool
    func folderExists(at path: URL?) -> Bool
    func fileOrFolderExists(at path: URL?) -> Bool
    func readFile(from path: URL?) -> String?
    func copyFile(from originPath: URL?, to destinationPath: URL?) -> Bool
    func replaceFileContent(from path: URL?, with content: String) -> Bool
    func path(of folder: Folders) -> URL?
    func append(folder: String, at rootFolder: Folders) -> URL?
    func append(folders: [String], at rootFolder: Folders) -> URL?
    func append(folder: String, atURL rootFolder: URL?) -> URL?
    func append(folders: [String], atURL rootFolder: URL?) -> URL?
    func contentsOfDirectory(atURL: URL) throws -> [String]
}

public extension Repository {
    func createFolder(
        inside folder: Folders,
        name: String,
        deleteIfExists: Bool = false
    ) -> Bool {
        createFolder(inside: folder, name: name, deleteIfExists: deleteIfExists)
    }
}

struct RepositoryImpl: Repository {
    @Injected(\.shell) var shell: Shell

    func createFolder(
        inside folder: Folders,
        name: String,
        deleteIfExists: Bool = false
    ) -> Bool {
        guard let path = path(of: folder)?.appendPath(name) else { return false }

        if FileManager.default.fileExists(atPath: path.absoluteString) {
            guard deleteIfExists else { return false }

            delete(at: path)
        }

        do {
            try FileManager.default.createDirectory(atPath: path.absoluteString, withIntermediateDirectories: true)
        } catch {
            return false
        }

        return true
    }

    func createFolder(at path: URL?, deleteIfExists: Bool) -> Bool {
        guard let path else { return false}

        if FileManager.default.fileExists(atPath: path.absoluteString) {
            guard deleteIfExists else { return false }

            delete(at: path)
        }

        do {
            try FileManager.default.createDirectory(atPath: path.absoluteString, withIntermediateDirectories: true)
        } catch {
            return false
        }

        return true
    }


    @discardableResult func delete(at path: URL?) -> Bool {
        guard let path else { return false }

        do {
            try FileManager.default.removeItem(atPath: path.absoluteString)
        } catch {
            return false
        }

        return true
    }

    @discardableResult func deleteFile(at path: URL?, name: String) -> Bool {
        guard let path = path?.appendPath(name) else { return false }

        do {
            try FileManager.default.removeItem(atPath: path.absoluteString)
        } catch {
            return false
        }

        return true
    }

    func fileExists(at path: URL?) -> Bool {
        guard let path else { return false }
        var isDirectory = ObjCBool(false)
        return FileManager.default.fileExists(
            atPath: path.absoluteString,
            isDirectory: &isDirectory) && !isDirectory.boolValue
    }

    func folderExists(at path: URL?) -> Bool {
        guard let path else { return false }
        var isDirectory = ObjCBool(false)
        return FileManager.default.fileExists(
            atPath: path.absoluteString,
            isDirectory: &isDirectory) && isDirectory.boolValue
    }

    func fileOrFolderExists(at path: URL?) -> Bool {
        guard let path else { return false }
        return FileManager.default.fileExists(atPath: path.absoluteString)
    }

    func readFile(from path: URL?) -> String? {
        guard let path else { return nil }

        return try? String(contentsOfFile: path.absoluteString)
    }

    func copyFile(from originPath: URL?, to destinationPath: URL?) -> Bool {
        guard let originPath, let destinationPath else { return false }

        do {
            try FileManager.default.copyItem(
                atPath: originPath.absoluteString,
                toPath: destinationPath.absoluteString
            )
        } catch {
            return false
        }

        return true
    }

    func replaceFileContent(from path: URL?, with content: String) -> Bool {
        guard let path else { return false }

        do {
            try content.write(toFile: path.absoluteString, atomically: true, encoding: .utf8)
        } catch {
            return false
        }

        return true
    }

    func path(of folder: Folders) -> URL? {
        switch folder {
        case .root:
            guard let path = URL(string: #file) else { return nil }
            var rootPath = path
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .path()
            
            if rootPath.hasSuffix("/") {
                rootPath = String(rootPath.dropLast())
            }
            
            return URL(string: rootPath)
        case .resources:
            return append(folder: "Resources", at: .root)
        case .externalLibraries:
            return append(folder: "ExternalLibraries", at: .resources)
        case .sourceryBinary:
            return append(folders: ["Sourcery-2.0.2", "bin", "sourcery"], at: .externalLibraries)
        case .templates:
            return append(folder: "Templates", at: .resources)
        case .makeSwiftScriptTemplates:
            return append(folder: "MakeSwiftScript", at: .templates)
        }
    }

    func append(folder: String, at rootFolder: Folders) -> URL? {
        guard var url = path(of: rootFolder) else {
            return nil
        }

        url = url.appendPath(folder)
        return url
    }

    func append(folders: [String], at rootFolder: Folders) -> URL? {
        guard var url = path(of: rootFolder) else {
            return nil
        }

        for childFolder in folders {
            url = url.appendPath(childFolder)
        }

        return url
    }

    func append(folder: String, atURL rootFolder: URL?) -> URL? {
        guard let rootFolder else {
            return nil
        }
        var url = rootFolder

        url = url.appendPath(folder)
        return url
    }

    func append(folders: [String], atURL rootFolder: URL?) -> URL? {
        guard let rootFolder else {
            return nil
        }
        var url = rootFolder

        for childFolder in folders {
            url = url.appendPath(childFolder)
        }

        return url
    }

    func contentsOfDirectory(atURL: URL) throws -> [String] {
        return try FileManager.default.contentsOfDirectory(atPath: atURL.absoluteString)
    }
}

public enum Folders: String {
    case root
    case resources
    case externalLibraries
    case sourceryBinary
    case templates
    case makeSwiftScriptTemplates
}

public extension URL {
    func appendPath(_ path: String) -> URL {
        if #available(macOS 13.0, *) {
            return self.appending(path: path)
        } else {
            return self.appendingPathComponent(path)
        }
    }
}
