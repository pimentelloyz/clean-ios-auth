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

extension MainQueueDispatchDecorator: GenerateToken where T: GenerateToken {
    public func generate(by parameters: GenerateTokenParameters, completion: @escaping (GenerateToken.Result) -> Void) {
        instance.generate(by: parameters) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: RefreshToken where T: RefreshToken {
    public func refresh(completion: @escaping (GenerateToken.Result) -> Void) {
        instance.refresh() { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: LoadProductRegisteredByAccount where T: LoadProductRegisteredByAccount {
    public func load(by params: LoadProductRegisteredParameters, completion: @escaping (LoadProductRegisteredByAccount.Result) -> Void) {
        instance.load(by: params) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
