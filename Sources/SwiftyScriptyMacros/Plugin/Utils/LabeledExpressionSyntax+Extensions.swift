import SwiftSyntax
import SwiftSyntaxMacros

extension LabeledExprListSyntax.Element {
    var parameter: (label: String, value: String)? {
        guard let label = label?.text else { return nil }
        
        if let str = expression.as(StringLiteralExprSyntax.self)?.text {
            return (label, str)
        }

        if let bool = expression.as(BooleanLiteralExprSyntax.self)?.literal.text {
            return (label, bool)
        }
        
        if let integer = expression.as(IntegerLiteralExprSyntax.self)?.literal.text {
            return (label, integer)
        }

        if let float = expression.as(FloatLiteralExprSyntax.self)?.literal.text {
            return (label, float)
        }

        return nil
    }
}

extension StringLiteralExprSyntax {
    var text: String? {
        let text = segments.compactMap { $0.as(StringSegmentSyntax.self)?.content.text }.joined()
        
        return text.isEmpty ? nil : text
    }
}
