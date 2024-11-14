import Foundation

extension FileHandle {
    func setReadabilityHandler(_ handler: @escaping (FileHandle) async -> Void) {
        readabilityHandler = { handle in
            Task { await handler(handle) }
        }
    }

    func setStringHandler(_ handler: @escaping (String) async -> Void) {
        readabilityHandler = { handle in
            guard let str = String(data: handle.availableData, encoding: .utf8), !str.isEmpty else { return }

            Task { await handler(str) }
        }
    }
}
