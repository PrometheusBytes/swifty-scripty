import SwiftyScriptyMacros

@Injectable
protocol FileUtility {}

struct FileUtilityImpl: FileUtility {}

extension InjectedValues {
    #injected(FileUtility.self)
}

protocol InjectionKey {
    associatedtype Value
    static var liveValue: Value { get }
}

struct InjectedValues {
    public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.liveValue }
    }
}
