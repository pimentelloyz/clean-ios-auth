import Foundation
import Data

class HttpGetClientSpy: HttpGetClient {
    var url: URL?
    var headers: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func get(to url: URL, by params: Data?, headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.url        = url
        self.headers    = headers
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        self.completion?(.failure(error))
    }
    
    func completesWithData(data: Data?) {
        self.completion?(.success(data))
    }
}
