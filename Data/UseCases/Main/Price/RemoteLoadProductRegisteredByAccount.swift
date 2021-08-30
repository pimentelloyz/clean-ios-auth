import Foundation
import Domain

public class RemoteLoadProductRegisteredByAccount: LoadProductRegisteredByAccount {
    public let url: URL
    public let httpClient: HttpGetClient
    public let authenticationHeaders: AuthenticationHeaders
    
    public init(url: URL,
                httpClient: HttpGetClient,
                authenticationHeaders: AuthenticationHeaders) {
        self.url                    = url
        self.httpClient             = httpClient
        self.authenticationHeaders  = authenticationHeaders
    }
    
    public func load(by params: LoadProductRegisteredParameters, completion: @escaping (LoadProductRegisteredByAccount.Result) -> Void) {
        self.httpClient.get(to: url, by: params.toData(), headers: authenticationHeaders.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let productRegistered: ProductRegisteredByAccount = data?.toModel() {
                    completion(.success(productRegistered))
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
