import Foundation
import SwiftyScriptyMacros

// MARK: - FileUtility Protocol

/// FileUtility: A protocol defining common file and folder operations.
///
/// This protocol specifies methods for checking the existence of files and folders, creating folders, deleting files, copying files, reading from files, and writing to files.
@InjectableMacro(implementationName: "FileUtilityImpl")
public protocol FileUtility {
    /// Checks if a folder exists at the specified path.
    ///
    /// - Parameter path: The URL of the folder.
    /// - Returns: `true` if the folder exists, `false` otherwise.
    func folderExists(at path: URL) -> Bool
    
    /// Checks if a file exists at the specified path.
    ///
    /// - Parameter path: The URL of the file.
    /// - Returns: `true` if the file exists, `false` otherwise.
    func fileExists(at path: URL) -> Bool
    
    /// Checks if a file or folder exists at the specified path.
    ///
    /// - Parameter path: The URL of the file or folder.
    /// - Returns: `true` if the file or folder exists, `false` otherwise.
    func fileOrFolderExists(at path: URL) -> Bool
    
    /// Creates a folder at the specified path.
    ///
    /// - Parameters:
    ///   - path: The URL of the folder to be created.
    ///   - deleteIfExists: A Boolean value indicating whether to delete the folder if it already exists.
    /// - Returns: `true` if the folder was created successfully, `false` otherwise.
    @discardableResult
    func createFolder(at path: URL, deleteIfExists: Bool) -> Bool
    
    /// Deletes a file at the specified path.
    ///
    /// - Parameter path: The URL of the file to be deleted.
    /// - Returns: `true` if the file was deleted successfully, `false` otherwise.
    @discardableResult
    func deleteFile(at path: URL) -> Bool
    
    /// Deletes a file at the specified path with the given name.
    ///
    /// - Parameters:
    ///   - path: The URL of the folder containing the file.
    ///   - name: The name of the file to be deleted.
    /// - Returns: `true` if the file was deleted successfully, `false` otherwise.
    @discardableResult
    func deleteFile(at path: URL, name: String) -> Bool
    
    /// Copies a file from the origin URL to the destination URL.
    ///
    /// - Parameters:
    ///   - origin: The URL of the file to be copied.
    ///   - destination: The URL to which the file should be copied.
    /// - Returns: `true` if the file was copied successfully, `false` otherwise.
    @discardableResult
    func copyFile(from origin: URL, to destination: URL) -> Bool
    
    /// Reads the content of a file at the specified path.
    ///
    /// - Parameter path: The URL of the file to be read.
    /// - Returns: A `String` containing the content of the file, or `nil` if the file could not be read.
    func readFile(at path: URL) -> String?
    
    /// Writes the specified content to a file at the specified path.
    ///
    /// - Parameters:
    ///   - content: The content to be written to the file.
    ///   - path: The URL of the file to be written.
    /// - Returns: `true` if the file was written successfully, `false` otherwise.
    @discardableResult
    func writeFile(content: String, to path: URL) -> Bool
}

// MARK: - FileUtility Implementation

/// FileUtilityImpl: A concrete implementation of the FileUtility protocol.
///
/// This struct provides implementations for common file and folder operations using the FileManager class.
struct FileUtilityImpl: FileUtility {
    /// The shell utility used to execute commands.
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
