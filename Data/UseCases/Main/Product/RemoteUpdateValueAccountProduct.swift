import Foundation
import Domain

public final class RemoteUpdateValueAccountProduct: UpdateValueAccountProduct {
    public var url: URL
    public var httpClient: HttpPutClient
    public let authenticationHeaders: AuthenticationHeaders
    
    public init(url: URL,
                httpClient: HttpPutClient,
                authenticationHeaders: AuthenticationHeaders) {
        self.url = url
        self.httpClient = httpClient
        self.authenticationHeaders  = authenticationHeaders
    }
    
    public func update(by params: UpdateValueAccountProductParameters, to pathComponent: PathComponent, completion: @escaping (UpdateValueAccountProduct.Result) -> Void) {
        self.httpClient.put(to: self.url.appendingPathComponent(pathComponent.path), with: params.toData(), headers: authenticationHeaders.toData()) { [weak self] result in
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
