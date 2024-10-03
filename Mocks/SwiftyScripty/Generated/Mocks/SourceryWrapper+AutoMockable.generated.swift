// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import SwiftyScripty

public class SourceryWrapperMock: SourceryWrapper {

    public init() {}

    //MARK: - generateCode

    public var generateCodeConfigPathArgsCallsCount = 0
    public var generateCodeConfigPathArgsCalled: Bool {
        return generateCodeConfigPathArgsCallsCount > 0
    }
    public var generateCodeConfigPathArgsReceivedArguments: (configPath: URL, args: [SourceryWrapperArguments])?
    public var generateCodeConfigPathArgsReceivedInvocations: [(configPath: URL, args: [SourceryWrapperArguments])] = []
    public var generateCodeConfigPathArgsReturnValue: Command!
    public var generateCodeConfigPathArgsClosure: ((URL, [SourceryWrapperArguments]) -> Command)?

    public func generateCode(configPath: URL, args: [SourceryWrapperArguments]) -> Command {
        generateCodeConfigPathArgsCallsCount += 1
        generateCodeConfigPathArgsReceivedArguments = (configPath: configPath, args: args)
        generateCodeConfigPathArgsReceivedInvocations.append((configPath: configPath, args: args))
        return generateCodeConfigPathArgsClosure.map({ $0(configPath, args) }) ?? generateCodeConfigPathArgsReturnValue
    }

    //MARK: - generateCode

    public var generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderCallsCount = 0
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderCalled: Bool {
        return generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderCallsCount > 0
    }
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderReceivedArguments: (templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments], trimSourceryHeader: Bool)?
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderReceivedInvocations: [(templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments], trimSourceryHeader: Bool)] = []
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderReturnValue: Command!
    public var generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderClosure: (([URL], [URL], URL, [SourceryWrapperArguments], Bool) -> Command)?

    public func generateCode(templatePaths: [URL], sourcePaths: [URL], outputPath: URL, args: [SourceryWrapperArguments], trimSourceryHeader: Bool) -> Command {
        generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderCallsCount += 1
        generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderReceivedArguments = (templatePaths: templatePaths, sourcePaths: sourcePaths, outputPath: outputPath, args: args, trimSourceryHeader: trimSourceryHeader)
        generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderReceivedInvocations.append((templatePaths: templatePaths, sourcePaths: sourcePaths, outputPath: outputPath, args: args, trimSourceryHeader: trimSourceryHeader))
        return generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderClosure.map({ $0(templatePaths, sourcePaths, outputPath, args, trimSourceryHeader) }) ?? generateCodeTemplatePathsSourcePathsOutputPathArgsTrimSourceryHeaderReturnValue
    }

}
