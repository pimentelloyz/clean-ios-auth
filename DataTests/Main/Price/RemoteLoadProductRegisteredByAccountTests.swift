import XCTest
import Foundation
import Domain
import Data

class RemoteLoadProductRegisteredByAccount {
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
    
    func load(by params: LoadProductRegisteredParameters, completion: @escaping (LoadProductRegistredByAccount.Result) -> Void) {
        self.httpClient.get(to: url, by: params.toData(), headers: authenticationHeaders.toData()) { result in
            switch result {
            case .success: completion(.failure(.unexpected))
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}

class HttpGetClientSpy: HttpGetClient {
    var url: URL?
    var headers: Data?
    
    func get(to url: URL, by params: Data?, headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.url        = url
        self.headers    = headers
    }
}

class RemoteLoadProductRegisteredByAccountTests: XCTestCase {
    func test_should_call_httpClient_with_correct_url() throws {
        let url = makeUrl()
        let (sut, httpGetClientSpy, _) = makeSut(url: url)
        sut.load(by: makeLoadProductRegisteredByAccountParams()) { _ in }
        
        XCTAssertEqual(httpGetClientSpy.url, url)
    }
    
    func test_shoul_call_with_correct_headers() throws {
        let (sut, httpGetClientSpy, authenticationHeaders) = makeSut(authenticationHeaders: makeAuthenticationHeaders())
        
        sut.load(by: makeLoadProductRegisteredByAccountParams()) { _ in }
        
        XCTAssertEqual(httpGetClientSpy.headers, authenticationHeaders.toData())
    }
}

extension RemoteLoadProductRegisteredByAccountTests {
    func makeSut(url: URL = makeUrl(), authenticationHeaders: AuthenticationHeaders = makeAuthenticationHeaders()) -> (sut: RemoteLoadProductRegisteredByAccount, httpGetClientSpy: HttpGetClientSpy, authenticationHeaders: AuthenticationHeaders) {
        let httpGetClientSpy = HttpGetClientSpy()
        let sut = RemoteLoadProductRegisteredByAccount(url: url, httpClient: httpGetClientSpy, authenticationHeaders: authenticationHeaders)
        return (sut, httpGetClientSpy, authenticationHeaders)
    }
}
