import Foundation

public protocol RefreshToken {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func refresh(completion: @escaping (Result) -> Void)
}
