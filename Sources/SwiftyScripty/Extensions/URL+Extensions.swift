import Foundation

public extension URL {
    func getFullPath() -> String {
        self.path().removingPercentEncoding ?? self.path()
    }
}
