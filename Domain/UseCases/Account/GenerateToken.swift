import Foundation

public protocol GenerateToken {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func generate(by parameters: GenerateTokenParameters, completion: @escaping (Result) -> Void)
}

public struct GenerateTokenParameters: Model {
    public let email: String
    
    public init(email: String) {
        self.email = email
    }
}
