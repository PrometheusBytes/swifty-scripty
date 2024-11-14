import Foundation

enum TaskProvider {
    static func cancellableContinuationTask<Result>(
        for continuationBody: @escaping (UnsafeContinuation<Result, any Error>) -> Void,
        onCancel: @escaping () -> Void
    ) -> Task<Result, any Error> {
        return Task {
            var heldContinuation: UnsafeContinuation<Result, any Error>?
            let onCancelHandler = {
                onCancel()
                heldContinuation?.resume(throwing: TaskError.continuationCancelled)
            }

            return try await withTaskCancellationHandler {
                try await withUnsafeThrowingContinuation { continuation in
                    heldContinuation = continuation
                    continuationBody(continuation)
                }
            } onCancel: {
                onCancelHandler()
            }
        }
    }
}

enum TaskError: Error {
    case continuationCancelled
}
