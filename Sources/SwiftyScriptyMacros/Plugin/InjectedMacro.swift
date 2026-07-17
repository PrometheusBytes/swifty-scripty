import SwiftSyntax
import SwiftSyntaxMacros

public struct InjectedMacro: DeclarationMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard
            let first = node.arguments.first,
            let member = first.expression.as(MemberAccessExprSyntax.self),
            member.declName.baseName.text == "self",
            let base = member.base?.as(DeclReferenceExprSyntax.self)
        else {
            return []
        }
        
        let typeName = base.baseName.text
        let accessLevel = if let access: String = node.param(for: "accessLevel"), !access.isEmpty {
            "\(access) "
        } else { "" }
        
        return [
            """
            \(raw: accessLevel)var \(raw: typeName.lowerFirstWord): \(raw: typeName) {
                get { return Self[\(raw: typeName)DependencyKey.self] }
            }
            """
        ]
    }
}
