// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

public class SourceryWrapperMock: SourceryWrapper {

    public init() {}

    //MARK: - generateCode

    public var generateCodeConfigPathArgsCallsCount = 0
    public var generateCodeConfigPathArgsCalled: Bool {
        return generateCodeConfigPathArgsCallsCount > 0
    }
    public var generateCodeConfigPathArgsReceivedArguments: (configPath: URL, args: [SourceryWrapperArguments])?
    public var generateCodeConfigPathArgsReceivedInvocations: [(configPath: URL, args: [SourceryWrapperArguments])] = []
    public var generateCodeConfigPathArgsReturnValue: Bool!
    public var generateCodeConfigPathArgsClosure: ((URL, [SourceryWrapperArguments]) -> Bool)?

    public func generateCode(configPath: URL, args: [SourceryWrapperArguments]) -> Bool {
        generateCodeConfigPathArgsCallsCount += 1
        generateCodeConfigPathArgsReceivedArguments = (configPath: configPath, args: args)
        generateCodeConfigPathArgsReceivedInvocations.append((configPath: configPath, args: args))
        return generateCodeConfigPathArgsClosure.map({ $0(configPath, args) }) ?? generateCodeConfigPathArgsReturnValue
    }

    //MARK: - generateCode

    public var generateCodeTemplatePathsSourcePathsOutputPathArgsCallsCount = 0
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsCalled: Bool {
        return generateCodeTemplatePathsSourcePathsOutputPathArgsCallsCount > 0
    }
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsReceivedArguments: (templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments])?
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsReceivedInvocations: [(templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments])] = []
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsReturnValue: Bool!
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsClosure: (([URL], [URL], URL, [SourceryWrapperArguments]) -> Bool)?

    public func generateCode(templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments]) -> Bool {
        generateCodeTemplatePathsSourcePathsOutputPathArgsCallsCount += 1
        generateCodeTemplatePathsSourcePathsOutputPathArgsReceivedArguments = (templatePaths: templatePaths, sourcePaths: sourcePaths, outputPath: outputPath, args: args)
        generateCodeTemplatePathsSourcePathsOutputPathArgsReceivedInvocations.append((templatePaths: templatePaths, sourcePaths: sourcePaths, outputPath: outputPath, args: args))
        return generateCodeTemplatePathsSourcePathsOutputPathArgsClosure.map({ $0(templatePaths, sourcePaths, outputPath, args) }) ?? generateCodeTemplatePathsSourcePathsOutputPathArgsReturnValue
    }

}
