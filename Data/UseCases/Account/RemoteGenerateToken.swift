import Foundation
import Domain

public final class RemoteGenerateToken: GenerateToken {
    public var url: URL
    public var httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func generate(by parameters: GenerateTokenParameters, completion: @escaping (GenerateToken.Result) -> Void) {
        self.httpClient.post(to: self.url, with: parameters.toData(), and: nil) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let accountModel: AccountModel = data?.toModel() {
                    completion(.success(accountModel))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .unauthorized:
                    completion(.failure(.expiredSession))
                case .forbidden:
                    completion(.failure(.unauthorized))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
