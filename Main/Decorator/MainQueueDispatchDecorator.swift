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

extension MainQueueDispatchDecorator: LoadProductNotRegisteredByAccount where T: LoadProductNotRegisteredByAccount {
    public func load(by params: LoadProductNotRegisteredByAccountParameters, completion: @escaping (LoadProductNotRegisteredByAccount.Result) -> Void) {
        instance.load(by: params) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: AddValueAccountProduct where T: AddValueAccountProduct {
    public func add(with params: AddValueAccountProductParameters, completion: @escaping (AddValueAccountProduct.Result) -> Void) {
        instance.add(with: params) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: AddSignatureValue where T: AddSignatureValue {
    public func add(with params: AddSignatureValueParameters, completion: @escaping (AddSignatureValue.Result) -> Void) {
        instance.add(with: params) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: UpdateValueAccountProduct where T: UpdateValueAccountProduct {
    public func update(by params: UpdateValueAccountProductParameters, to pathComponent: PathComponent, completion: @escaping (UpdateValueAccountProduct.Result) -> Void) {
        instance.update(by: params, to: pathComponent) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: UpdateSignatureValue where T: UpdateSignatureValue {
    public func update(with params: UpdateSignatureValueParemeters, to pathComponent: PathComponent, completion: @escaping (UpdateSignatureValue.Result) -> Void) {
        instance.update(with: params, to: pathComponent) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}


extension MainQueueDispatchDecorator: DeleteProductAccount where T: DeleteProductAccount {
    public func delete(to pathComponent: PathComponent, completion: @escaping (DeleteProductAccount.Result) -> Void) {
        instance.delete(to: pathComponent) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
