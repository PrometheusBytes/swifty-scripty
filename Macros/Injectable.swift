import SwiftSyntaxMacros

@attached(peer, names: suffixed(Key))
@attached(extension, names: arbitrary)
public macro InjectableMacro(implementationName: String) = #externalMacro(module: "SwiftyScriptyMacros", type: "InjectableMacro")
