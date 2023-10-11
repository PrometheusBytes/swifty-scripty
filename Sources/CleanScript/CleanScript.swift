import Foundation
import SwiftyScripty
import RegexBuilder
import ArgumentParser

@main
struct CleanScript: ParsableCommand {
    enum CodingKeys: CodingKey {
        case scriptPath
        case testsPath
    }
    
    // MARK: - Parameters

    @Argument(help: "The phrase to repeat.")
    var scriptPath: String

    @Argument(help: "The test to repeat.")
    var testsPath: String
    
    // MARK: - Injected Values

    @Injected(\.shell) var shell
    @Injected(\.repository) var repository

    mutating func run() throws {
        guard
            let path = URL(string: scriptPath),
            let testPath = URL(string: testsPath)
        else {
            shell.print(color: .yellow, text: "Warning: script path not found")
            shell.exit(with: .errorExitCode)
            return
        }

        let generatedKeysFolder = path.appendPath("InjectionKeys")
        let generatedMocksFolder = testPath.appendPath("Generated")
        let registratorPath = testPath.appendPath("Registrator.swift")
        
        guard repository.folderExists(at: path) else {
            shell.print(color: .red, text: "Script folder not found")
            shell.exit(with: .errorExitCode)
            return
        }

        // Remove generated injection keys
        if repository.folderExists(at: generatedKeysFolder) {
            shell.print(color: .green, text: "Removing generated injection keys...")
            repository.delete(at: generatedKeysFolder)
        }

        // Remove generated mocks
        if repository.folderExists(at: generatedMocksFolder) {
            shell.print(color: .green, text: "Removing generated Mocks...")
            repository.delete(at: generatedMocksFolder)
        }

        // Clean Registrator
        if cleanRegistrator(at: registratorPath) {
            shell.print(color: .green, text: "Cleaned Registrator")
        }
    }

    private func cleanRegistrator(at path: URL?) -> Bool {
        guard let file = repository.readFile(from: path) else { return false }

        var lines = file.split(separator: "\n", omittingEmptySubsequences: false)
        let startRegex = /\/\/\ ?sourcery\:inline:[^\.]*\.InlineRegistrator/
        let endRegex = /\/\/\ ?sourcery\:end/
        
        guard
            let startIndex = computeIndex(in: lines, regex: startRegex),
            let endIndex = computeIndex(in: lines, regex: endRegex),
            startIndex < endIndex,
            endIndex < lines.count
        else {
            return false
        }
        
        lines.removeSubrange(startIndex + 1 ..< endIndex)
        return repository.replaceFileContent(from: path, with: lines.joined(separator: "\n"))
    }

    private func computeIndex(in lines: [Substring], regex: Regex<Substring>) -> Int? {
        guard
            let line = lines.first(where: { (try? regex.firstMatch(in: $0)) != nil }),
            let index = lines.firstIndex(of: line)
        else {
            return nil
        }

        return index
    }
}
