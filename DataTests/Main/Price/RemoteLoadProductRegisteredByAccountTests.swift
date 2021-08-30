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
    
    func load(by params: LoadProductRegisteredParameters, completion: @escaping (LoadProductRegisteredByAccount.Result) -> Void) {
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
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func get(to url: URL, by params: Data?, headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.url        = url
        self.headers    = headers
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        self.completion?(.failure(error))
    }
}

class RemoteLoadProductRegisteredByAccountTests: XCTestCase {
    func test_load_should_call_httpClient_with_correct_url() throws {
        let url = makeUrl()
        let (sut, httpGetClientSpy, _) = makeSut(url: url)
        sut.load(by: makeLoadProductRegisteredByAccountParams()) { _ in }
        
        XCTAssertEqual(httpGetClientSpy.url, url)
    }
    
    func test_load_should_call_with_correct_headers() throws {
        let (sut, httpGetClientSpy, authenticationHeaders) = makeSut(authenticationHeaders: makeAuthenticationHeaders())
        
        sut.load(by: makeLoadProductRegisteredByAccountParams()) { _ in }
        
        XCTAssertEqual(httpGetClientSpy.headers, authenticationHeaders.toData())
    }
    
    func test_load_should_complete_with_error_if_httpClient_fails() throws {
        let (sut, httpGetClientSpy, _) = makeSut()
        expect(sut: sut, completeWith: .failure(.unexpected)) {
            httpGetClientSpy.completeWithError(.noConnectivity)
        }
    }
}

extension RemoteLoadProductRegisteredByAccountTests {
    func makeSut(url: URL = makeUrl(), authenticationHeaders: AuthenticationHeaders = makeAuthenticationHeaders()) -> (sut: RemoteLoadProductRegisteredByAccount, httpGetClientSpy: HttpGetClientSpy, authenticationHeaders: AuthenticationHeaders) {
        let httpGetClientSpy = HttpGetClientSpy()
        let sut = RemoteLoadProductRegisteredByAccount(url: url, httpClient: httpGetClientSpy, authenticationHeaders: authenticationHeaders)
        return (sut, httpGetClientSpy, authenticationHeaders)
    }
    
    func expect(sut: RemoteLoadProductRegisteredByAccount, completeWith expectedResult: LoadProductRegisteredByAccount.Result, action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.load(by: makeLoadProductRegisteredByAccountParams()) { receivedResult in
            switch (receivedResult, expectedResult) {
            case (.failure(let receivedError), .failure(let expectedError)): XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            case (.success(let receivedData), .success(let expectedData)): XCTAssertEqual(receivedData, expectedData, file: file, line: line)
            default: XCTFail("Expected \(expectedResult), received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
