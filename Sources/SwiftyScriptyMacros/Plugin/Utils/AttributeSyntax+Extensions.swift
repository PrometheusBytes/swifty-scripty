import SwiftSyntax
import SwiftSyntaxMacros

extension AttributeSyntax {
    var parameters: [(String, String)] {
        if let arguments = self.arguments?.as(LabeledExprListSyntax.self) {
            arguments.compactMap { $0.parameter }
        } else {
            []
        }
    }

    func param(for label: String) -> String? { parameters.first(where: { $0.0 == label })?.1 }
    func param(for label: String) -> Bool? {
        if let param = parameters.first(where: { $0.0 == label })?.1 {
            param == "true"
        } else { nil }
    }
}

extension FreestandingMacroExpansionSyntax {
    var parameters: [(String, String)] { arguments.compactMap { $0.parameter } }

    func param(for label: String) -> String? { parameters.first(where: { $0.0 == label })?.1 }
    func param(for label: String) -> Bool? {
        if let param = parameters.first(where: { $0.0 == label })?.1 {
            param == "true"
        } else { nil }
    }
}
