import Foundation
import Alamofire
import Data

public final class AlamofirePostAdapter: HttpPostClient {
    private let session: SessionManager
    public typealias Result = Swift.Result
    public init(session: SessionManager = .default) {
        self.session = session
    }
    
    public func post(to url: URL, with data: Data?, headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default, headers: headers?.toHeaders()).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else { return completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            }
        }
    }
}
