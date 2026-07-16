import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SwiftyScriptyMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        InjectableMacro.self,
        InjectedMacro.self
    ]
}
