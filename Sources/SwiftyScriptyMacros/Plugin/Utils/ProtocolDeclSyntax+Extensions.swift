import SwiftSyntax
import SwiftSyntaxMacros

extension ProtocolDeclSyntax {
    var accessLevel: String {
        modifiers.compactMap {
            switch $0.name.tokenKind {
            case .keyword(.public): "public"
            case .keyword(.internal): "internal"
            case .keyword(.fileprivate): "fileprivate"
            case .keyword(.private): "private"
            case .keyword(.package): "package"
            case .keyword(.open): "open"
            default: ""
            }
        }.first ?? ""
    }

    var normalizedAccessLevel: String {
        modifiers.compactMap {
            switch $0.name.tokenKind {
            case .keyword(.public), .keyword(.open): "public "
            case .keyword(.fileprivate): "fileprivate "
            case .keyword(.private): "private "
            case .keyword(.package): "package "
            default: ""
            }
        }.first ?? ""
    }
}
