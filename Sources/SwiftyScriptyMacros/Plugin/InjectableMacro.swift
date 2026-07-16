import SwiftSyntax
import SwiftSyntaxMacros

public struct InjectableMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let proto = declaration.as(ProtocolDeclSyntax.self) else { return [] }

        let protocolName = proto.name.text
        let implementationName = node.param(for: "implementationName") ?? "\(protocolName)Impl"

        return [
            """
            \(raw: proto.normalizedAccessLevel)struct \(raw: protocolName)DependencyKey: InjectionKey {
                \(raw: proto.normalizedAccessLevel)static var liveValue: \(raw: protocolName) { \(raw: implementationName)() }
            }
            """
        ]
    }
}
