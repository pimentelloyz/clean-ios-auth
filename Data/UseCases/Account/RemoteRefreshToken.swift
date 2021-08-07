import Foundation
import Domain

public final class RemoteRefreshToken: RefreshToken {
    public var url: URL
    public var httpClient: HttpGetClient
    public var authenticationHeaders: AuthenticationHeaders
    
    public init(url: URL,
                httpClient: HttpGetClient,
                authenticationHeaders: AuthenticationHeaders) {
        self.url = url
        self.httpClient = httpClient
        self.authenticationHeaders = authenticationHeaders
    }
    
    public func refresh(completion: @escaping (RefreshToken.Result) -> Void ){
        httpClient.get(to: self.url, with: nil, and: authenticationHeaders.toData()) { [weak self] result in
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
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
