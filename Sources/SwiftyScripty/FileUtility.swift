import Foundation

//sourcery: AutoMockable
public protocol FileUtility {
    func folderExists(at path: URL) -> Bool
    func fileExists(at path: URL) -> Bool
    func fileOrFolderExists(at path: URL) -> Bool
    @discardableResult
    func createFolder(at path: URL, deleteIfExists: Bool) -> Bool
    @discardableResult
    func deleteFile(at path: URL) -> Bool
    @discardableResult
    func deleteFile(at path: URL, name: String) -> Bool
    @discardableResult
    func copyFile(from origin: URL, to destination: URL) -> Bool
    func readFile(at path: URL) -> String?
    @discardableResult
    func writeFile(content: String, to path: URL) -> Bool
}

struct FileUtilityImpl: FileUtility {
    @Injected(\.shell) var shell: Shell

    func folderExists(at path: URL) -> Bool {
        var isDirectory = ObjCBool(false)
        return FileManager.default.fileExists(
            atPath: path.getFullPath(),
            isDirectory: &isDirectory
        ) && isDirectory.boolValue
    }

    func fileExists(at path: URL) -> Bool {
        var isDirectory = ObjCBool(false)
        return FileManager.default.fileExists(
            atPath: path.getFullPath(),
            isDirectory: &isDirectory
        ) && !isDirectory.boolValue
    }

    func fileOrFolderExists(at path: URL) -> Bool {
        FileManager.default.fileExists(atPath: path.getFullPath())
    }

    @discardableResult
    func createFolder(at path: URL, deleteIfExists: Bool) -> Bool {
        do {
            try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
        } catch {
            return false
        }

        return true
    }

    @discardableResult
    func deleteFile(at path: URL) -> Bool {
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            return false
        }

        return true
    }
    
    @discardableResult
    func deleteFile(at path: URL, name: String) -> Bool {
        let fullPath = path.appending(path: name)
        return deleteFile(at: fullPath)
    }
    
    @discardableResult
    func copyFile(from origin: URL, to destination: URL) -> Bool {
        do {
            try FileManager.default.copyItem(at: origin, to: destination)
        } catch {
            return false
        }

        return true
    }

    func readFile(at path: URL) -> String? {
        return try? String(contentsOfFile: path.getFullPath())
    }
    
    @discardableResult
    func writeFile(content: String, to path: URL) -> Bool {
        do {
            try content.write(to: path, atomically: true, encoding: .utf8)
        } catch {
            return false
        }

        return true
    }
}
