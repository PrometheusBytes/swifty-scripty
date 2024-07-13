import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SwiftyScriptyMacros: CompilerPlugin {
  let providingMacros: [Macro.Type] = [InjectableMacro.self]
}
