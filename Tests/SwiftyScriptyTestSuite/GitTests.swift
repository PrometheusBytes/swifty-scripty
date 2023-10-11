//import SwiftyScriptyTests
//@testable import SwiftyScripty
//import XCTest
//
//final class GitTests: ScriptTests {
//    var sut: GitImpl!
//    @InjectedMock(\.shell) var shellDependency: ShellMock
//
//    override func setUp() {
//        super.setUp()
//        sut = GitImpl()
//    }
//
//    func test_hasRepoChanges_givenChanges_thenReturnsTrue() {
//        // GIVEN
//        shellDependency.given(.zsh(command: .value("git status --porcelain"), executeFromRoot: .any, willReturn: "has changes"))
//
//        // WHEN
//        let changes = sut.hasRepoChanges()
//
//        // THEN
//        XCTAssertTrue(changes)
//        shellDependency.verify(
//            .zsh(
//                command: .value("git status --porcelain"),
//                executeFromRoot: .any),
//            count: 1
//        )
//    }
//
//    func test_hasRepoChanges_givenEmpty_thenReturnsFalse() {
//        // GIVEN
//        shellDependency.given(.zsh(command: .any, executeFromRoot: .any, willReturn: ""))
//
//        // WHEN
//        let changes = sut.hasRepoChanges()
//
//        // THEN
//        XCTAssertFalse(changes)
//        shellDependency.verify(
//            .zsh(
//                command: .value("git status --porcelain"),
//                executeFromRoot: .any),
//            count: 1
//        )
//    }
//
//    func test_hasRepoChanges_givenNil_thenReturnsFalse() {
//        // GIVEN
//        shellDependency.given(.zsh(command: .any, executeFromRoot: .any, willReturn: nil))
//
//        // WHEN
//        let changes = sut.hasRepoChanges()
//
//        // THEN
//        XCTAssertFalse(changes)
//        shellDependency.verify(
//            .zsh(
//                command: .value("git status --porcelain"),
//                executeFromRoot: .any
//            ),
//            count: 1
//        )
//    }
//
//    func test_discardChanges_thenExecutesCorrectCommands() {
//        // WHEN
//        sut.discardChanges()
//
//        // THEN
//        shellDependency.verify(
//            .runZsh(command: .value("git checkout ."), executeFromRoot: .any),
//            count: 1
//        )
//    }
//
//    func test_srcRoot_givenCorrectPath_thenReturnsCorrectString() {
//        // GIVEN
//        shellDependency.given(
//            .zsh(
//                command: .value("git rev-parse --show-toplevel"),
//                executeFromRoot: .any,
//                willReturn: "Return Path"
//            )
//        )
//
//        // WHEN
//        let path = sut.srcRoot
//
//        // THEN
//        XCTAssertEqual(path, "Return Path")
//    }
//}
