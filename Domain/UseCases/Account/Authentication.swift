import Foundation

public protocol Authentication {
    typealias Result = Swift.Result<AuthenticationModel, DomainError>
    func auth(completion: @escaping (Result) -> Void)
}
