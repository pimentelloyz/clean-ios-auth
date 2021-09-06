import Foundation
import Domain

public final class RemoteAddValueAccountProduct: AddValueAccountProduct {
    public var url: URL
    public var httpClient: HttpPostClient
    public let authenticationHeaders: AuthenticationHeaders
    
    public init(url: URL,
                httpClient: HttpPostClient,
                authenticationHeaders: AuthenticationHeaders) {
        self.url = url
        self.httpClient = httpClient
        self.authenticationHeaders  = authenticationHeaders
    }
    
    public func add(with params: AddValueAccountProductParameters, completion: @escaping (AddValueAccountProduct.Result) -> Void) {
        self.httpClient.post(to: self.url, with: params.toData(), headers: authenticationHeaders.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                completion(.success(NoContentModel(data: data)))
            case .failure(let error):
                switch error {
                case .unauthorized:
                    completion(.failure(.unauthorized))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
