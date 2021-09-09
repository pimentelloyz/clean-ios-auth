import Foundation
import Domain

public final class RemoteDeleteProductAccount: DeleteProductAccount {
    public let url: URL
    public let httpClient: HttpDeleteClient
    public let authenticationHeaders: AuthenticationHeaders
    
    public init(url: URL,
                httpClient: HttpDeleteClient,
                authenticationHeaders: AuthenticationHeaders) {
        self.url = url
        self.httpClient = httpClient
        self.authenticationHeaders = authenticationHeaders
    }
    
    public func delete(to pathComponent: PathComponent, completion: @escaping (DeleteProductAccount.Result) -> Void) {
        self.httpClient.delete(to: self.url.appendingPathComponent(pathComponent.path), with: nil, and: authenticationHeaders.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success:
                completion(.success(NoContentModel(data: nil)))
            case .failure(let error):
                switch error {
                case .unauthorized: completion(.failure(.expiredSession))
                default: completion(.failure(.unexpected))
                }
            }
        }
    }
}
