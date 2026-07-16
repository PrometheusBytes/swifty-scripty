import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
@testable import SwiftyScriptyMacrosPlugin

let testMacros: [String: Macro.Type] = [
    "Injectable": InjectableMacro.self,
    "injected": InjectedMacro.self,
]

final class InjectableMacroTests: XCTestCase {
    func testInternalProtocolEmitsInternalKey() {
        assertMacroExpansion(
            """
            @Injectable
            protocol Foo {
            }
            """,
            expandedSource: """
            protocol Foo {
            }

            struct FooDependencyKey: InjectionKey {
                static var liveValue: Foo {
                    FooImpl()
                }
            }
            """,
            macros: testMacros
        )
    }

    func testPublicProtocolEmitsPublicKey() {
        assertMacroExpansion(
            """
            @Injectable
            public protocol Foo {
            }
            """,
            expandedSource: """
            public protocol Foo {
            }

            public struct FooDependencyKey: InjectionKey {
                public static var liveValue: Foo {
                    FooImpl()
                }
            }
            """,
            macros: testMacros
        )
    }

    func testCustomImplementationName() {
        assertMacroExpansion(
            #"""
            @Injectable(implementationName: "LegacyFoo")
            protocol Foo {
            }
            """#,
            expandedSource: """
            protocol Foo {
            }

            struct FooDependencyKey: InjectionKey {
                static var liveValue: Foo {
                    LegacyFoo()
                }
            }
            """,
            macros: testMacros
        )
    }

    func testAttachedToNonProtocolEmitsNothing() {
        assertMacroExpansion(
            """
            @Injectable
            struct Foo {
            }
            """,
            expandedSource: """
            struct Foo {
            }
            """,
            macros: testMacros
        )
    }
}
