import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

enum MacroError: Error {
  case onlyApplicableToProtocol
  case implementationNameNotPresent
}

struct Helper {
  /// Extracts a `ProtocolDeclSyntax` instance from a given declaration.
  ///
  /// This method takes a declaration conforming to `DeclSyntaxProtocol` and attempts
  /// to downcast it to `ProtocolDeclSyntax`. If the downcast succeeds, the protocol declaration
  /// is returned. Otherwise, it emits an error indicating that the operation is only applicable
  /// to protocol declarations.
  ///
  /// - Parameter declaration: The declaration to be examined, conforming to `DeclSyntaxProtocol`.
  /// - Returns: A `ProtocolDeclSyntax` instance if the input declaration is a protocol declaration.
  /// - Throws: `SpyableDiagnostic.onlyApplicableToProtocol` if the input is not a protocol declaration.
  func extractProtocolDeclaration(
    from declaration: DeclSyntaxProtocol
  ) throws -> ProtocolDeclSyntax {
    guard let protocolDeclaration = declaration.as(ProtocolDeclSyntax.self) else {
      throw MacroError.onlyApplicableToProtocol
    }

    return protocolDeclaration
  }

  /// Extracts a preprocessor flag value from an attribute if present.
  ///
  /// This method analyzes an `AttributeSyntax` to find an argument labeled `behindPreprocessorFlag`.
  /// If found, it verifies that the argument's value is a static string literal. It then returns
  /// this string value. If the specific argument is not found, or if its value is not a static string,
  /// the method provides relevant diagnostics and returns `nil`.
  ///
  /// - Parameters:
  ///   - searchArgument: The argument that need to be searched.
  ///   - attribute: The attribute syntax to analyze.
  ///   - context: The macro expansion context in which this operation is performed.
  /// - Returns: The static string literal value of the `behindPreprocessorFlag` argument if present and valid.
  /// - Throws: Diagnostic errors for various failure cases, such as the absence of the argument or non-static string values.
  func extractArgument(
    search searchArgument: String,
    from attribute: AttributeSyntax,
    in context: some MacroExpansionContext
  ) throws -> String? {
    guard case let .argumentList(argumentList) = attribute.arguments else {
      // No arguments are present in the attribute.
      return nil
    }

    guard
      let foundedArgument = argumentList.first(where: { argument in
        argument.label?.text == searchArgument
      })
    else {
      // The `behindPreprocessorFlag` argument is missing.
      return nil
    }

    let segments = foundedArgument.expression
      .as(StringLiteralExprSyntax.self)?
      .segments

    guard let segments,
          segments.count == 1,
          case let .stringSegment(literalSegment)? = segments.first
    else {
      return nil
    }

    return literalSegment.content.text
  }
}

public struct InjectableMacro {}

extension InjectableMacro: PeerMacro {
  public static func expansion(
    of node: SwiftSyntax.AttributeSyntax,
    providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.DeclSyntax] {
    let helper = Helper()

    let protocolDeclaration = try helper.extractProtocolDeclaration(from: declaration)
    guard let implementationNameParamenter = try helper.extractArgument(search: "implementationName", from: node, in: context) else {
      return []
    }

    let protocolName = protocolDeclaration.name.text
    let structName = protocolName + "Key"

    return [
      """
      public struct \(raw: structName): InjectionKey {
        public static var liveValue: \(raw: protocolName) { \(raw: implementationNameParamenter)() }
      }
      """
    ]
  }
}

extension InjectableMacro: ExtensionMacro {
  public static func expansion(
    of node: SwiftSyntax.AttributeSyntax,
    attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
    providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
    conformingTo protocols: [SwiftSyntax.TypeSyntax],
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
    let helper = Helper()

    let protocolDeclaration = try helper.extractProtocolDeclaration(from: declaration)
    let protocolName = protocolDeclaration.name.text
    let structName = protocolName + "Key"

    let injectedValuesDeclSyntax: DeclSyntax =
      """
      extension InjectedValues {
        public var \(raw: protocolName.firstLowercased): \(raw: protocolName) {
          get { return Self[\(raw: structName).self] }
        }
      }
      """

    guard let injectedValuesExtension = injectedValuesDeclSyntax.as(ExtensionDeclSyntax.self) else {
      return []
    }

    return [injectedValuesExtension]
  }
}

extension StringProtocol {
  var firstLowercased: String { return prefix(1).lowercased() + dropFirst() }
}
