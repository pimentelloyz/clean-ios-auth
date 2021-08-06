import Foundation

public protocol Authentication {
    typealias Result = Swift.Result<Data, DomainError>
    func auth(completion: @escaping (Result) -> Void)
}
