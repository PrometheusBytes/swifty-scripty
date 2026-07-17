import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
@testable import SwiftyScriptyMacrosPlugin

final class InjectedMacroTests: XCTestCase {
    func testBasicExpansionIsInternal() {
        assertMacroExpansion(
            """
            extension InjectedValues {
                #injected(Foo.self)
            }
            """,
            expandedSource: """
            extension InjectedValues {
                var foo: Foo {
                    get {
                        return Self[FooDependencyKey.self]
                    }
                }
            }
            """,
            macros: testMacros
        )
    }

    func testPublicAccessLevel() {
        assertMacroExpansion(
            #"""
            extension InjectedValues {
                #injected(Foo.self, accessLevel: "public")
            }
            """#,
            expandedSource: """
            extension InjectedValues {
                public var foo: Foo {
                    get {
                        return Self[FooDependencyKey.self]
                    }
                }
            }
            """,
            macros: testMacros
        )
    }

    func testMultiWordTypeNameCamelCasesFirstWord() {
        assertMacroExpansion(
            """
            extension InjectedValues {
                #injected(MakeSwiftScript.self)
            }
            """,
            expandedSource: """
            extension InjectedValues {
                var makeSwiftScript: MakeSwiftScript {
                    get {
                        return Self[MakeSwiftScriptDependencyKey.self]
                    }
                }
            }
            """,
            macros: testMacros
        )
    }

    func testAcronymTypeNameLowercasesLeadingRun() {
        assertMacroExpansion(
            """
            extension InjectedValues {
                #injected(URLSession.self)
            }
            """,
            expandedSource: """
            extension InjectedValues {
                var urlSession: URLSession {
                    get {
                        return Self[URLSessionDependencyKey.self]
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
}
