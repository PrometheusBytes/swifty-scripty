@testable import SwiftyScripty
import SwiftyScriptyMocks
import XCTest

final class GitTests: XCTestCase {

    // MARK: - Properties

    var underTest: Git!
    @InjectedMock(\.shell) var shell: ShellMock

    // MARK: - SetUp

    override func setUp() {
        super.setUp()

        underTest = GitImpl()
    }

    // MARK: - Tests

    func test_getRoot_givenFailure_thenReturnsNil() async {
        // GIVEN
        shell.runCommandShellTypeReturnValue = Command(
            output: .rootPath,
            errorOutput: "",
            exitCode: .errorExitCode
        )

        // WHEN
        let path = await underTest.getRoot()

        // THEN
        XCTAssertNil(path)
    }

    func test_getRoot_thenReturnsRoot() async {
        // GIVEN
        shell.runCommandShellTypeReturnValue = Command(
            output: .rootPath,
            errorOutput: "",
            exitCode: .successExitCode
        )

        // WHEN
        let path = await underTest.getRoot()

        // THEN
        XCTAssertEqual(path, .rootPath)
    }

    func test_hasRepoChanges_givenNoStatus_thenReturnsFalse() async {
        // GIVEN
        shell.runCommandShellTypeReturnValue = Command(output: "", errorOutput: "", exitCode: .errorExitCode)

        // WHEN
        let hasChanges = await underTest.hasRepoChanges()

        // THEN
        XCTAssertFalse(hasChanges)
    }

    func test_hasRepoChanges_givenEmptyStatus_thenReturnsFalse() async {
        // GIVEN
        shell.runCommandShellTypeReturnValue = Command(output: "", errorOutput: "", exitCode: .successExitCode)

        // WHEN
        let hasChanges = await underTest.hasRepoChanges()

        // THEN
        XCTAssertFalse(hasChanges)
    }

    func test_hasRepoChanges_givenStatus_thenReturnsTrue() async {
        // GIVEN
        shell.runCommandShellTypeReturnValue = Command(
            output: .changes,
            errorOutput: "",
            exitCode: .successExitCode
        )

        // WHEN
        let hasChanges = await underTest.hasRepoChanges()

        // THEN
        XCTAssertTrue(hasChanges)
    }

    func test_discardChanges_thenCallsCommand() async {
        // WHEN
        await underTest.discardChanges()

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            .discardChanges
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_stageChanges_thenCallsCommand() async {
        // WHEN
        await underTest.stageChanges()

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            .stageChanges
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_commitChanges_thenCallsCommand() async {
        // GIVEN
        let message = "Updated Some Classes"
        let expectedCommand = "git commit -m \"\(message)\""
        shell.runCommandShellTypeReturnValue = Command(output: "", errorOutput: "", exitCode: .successExitCode)

        // WHEN
        await underTest.commitChanges(message: message)

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            expectedCommand
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_pull_thenCallsCommand() async {
        // WHEN
        await underTest.pull()

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            .pull
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_push_thenCallsCommand() async {
        // WHEN
        await underTest.push()

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            .push
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_createBranch_thenCallsCommand() async {
        // GIVEN
        let branchName = "New Branch"
        let expectedCommand = "git checkout -b \(branchName)"

        // WHEN
        await underTest.createBranch(branchName: branchName)

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            expectedCommand
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_switchToBranch_thenCallsCommand() async {
        // GIVEN
        let branchName = "New Branch"
        let expectedCommand = "git checkout \(branchName)"

        // WHEN
        await underTest.switchToBranch(branchName: branchName)

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            expectedCommand
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_mergeBranch_thenCallsCommand() async {
        // GIVEN
        let branchName = "New Branch"
        let expectedCommand = "git merge \(branchName)"

        // WHEN
        await underTest.mergeBranch(branchName: branchName)

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            expectedCommand
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_deleteBranch_thenCallsCommand() async {
        // GIVEN
        let branchName = "New Branch"
        let expectedCommand = "git branch -d \(branchName)"

        // WHEN
        await underTest.deleteBranch(branchName: branchName)

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            expectedCommand
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }

    func test_showLog_thenCallsCommand() async {
        // WHEN
        await underTest.showLog()

        // THEN
        XCTAssertTrue(shell.runCommandShellTypeCalled)
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.command,
            .log
        )
        XCTAssertEqual(
            shell.runCommandShellTypeReceivedArguments?.shellType,
            .zsh
        )
    }
}

// MARK: - Constants

fileprivate extension String {
    static let rootPath = "root/path"
    static let changes = "Changes to file A.swift"
    static let discardChanges = "git checkout ."
    static let stageChanges = "git add ."
    static let pull = "git pull"
    static let push = "git push"
    static let log = "git log"
}
