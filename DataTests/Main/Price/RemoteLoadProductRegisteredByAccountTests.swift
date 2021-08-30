import XCTest
import Foundation
import Domain
import Data

class RemoteLoadProductRegisteredByAccount {
    public let url: URL
    public let httpClient: HttpGetClient
    
    public init(url: URL,
                httpClient: HttpGetClient) {
        self.url        = url
        self.httpClient = httpClient
    }
    
    func load(by params: LoadProductRegisteredParameters, completion: @escaping (LoadProductRegistredByAccount.Result) -> Void) {
        self.httpClient.get(to: url, with: params.toData(), and: nil) { result in
            switch result {
            case .success: completion(.failure(.unexpected))
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}

class HttpGetClientSpy: HttpGetClient {
    var url: URL?
    
    func get(to url: URL, with params: Data?, and headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.url = url
    }
}

class RemoteLoadProductRegisteredByAccountTests: XCTestCase {
    func test_should_call_httpClient_with_correct_url() throws {
        let url = makeUrl()
        let (sut, httpGetClientSpy) = makeSut(url: url)
        sut.load(by: makeLoadProductRegisteredByAccountParams()) { _ in }
        
        XCTAssertEqual(httpGetClientSpy.url, url)
    }
}

extension RemoteLoadProductRegisteredByAccountTests {
    func makeSut(url: URL = makeUrl()) -> (sut: RemoteLoadProductRegisteredByAccount, httpGetClientSpy: HttpGetClientSpy) {
        let httpGetClientSpy = HttpGetClientSpy()
        let sut = RemoteLoadProductRegisteredByAccount(url: url, httpClient: httpGetClientSpy)
        return (sut, httpGetClientSpy)
    }
}
