import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread  else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainQueueDispatchDecorator: Authentication where T: Authentication {
    public func auth(completion: @escaping (Authentication.Result) -> Void) {
        instance.auth() { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
