import XCTest
import Foundation
import Domain
import Data

class RemoteLoadProductRegisteredByAccountTests: XCTestCase {
    func test_load_should_call_httpClient_with_correct_url() throws {
        let url = makeURL()
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
    
    func test_load_should_complete_with_sessionExpired_if_httpClient_completes_with_unauthorized() throws {
        let (sut, httpGetClientSpy, _) = makeSut()
        
        expect(sut: sut, completeWith: .failure(.expiredSession)) {
            httpGetClientSpy.completeWithError(.unauthorized)
        }
    }
    
    func test_load_should_complete_with_model_if_httpClient_completes_with_valid_data() throws {
        let (sut, httpGetClientSpy, _) = makeSut()
        let productModel = makeProductRegisteredByAccount()
        
        expect(sut: sut, completeWith: .success(productModel)) {
            httpGetClientSpy.completesWithData(data: productModel.toData())
        }
    }
    
    func test_load_should_not_completes_if_httpClient_completes_with_invalid_data() throws {
        let (sut, httpGetClientSpy, _) = makeSut()
        
        expect(sut: sut, completeWith: .failure(.unexpected)) {
            httpGetClientSpy.completesWithData(data: makeInvalidData())
        }
    }
    
    func test_load_should_not_complete_if_sut_has_bean_deallocated() throws {
        let httpGetClientSpy = HttpGetClientSpy()
        var sut: RemoteLoadProductRegisteredByAccount? = RemoteLoadProductRegisteredByAccount(url: makeURL(), httpClient: httpGetClientSpy, authenticationHeaders: makeAuthenticationHeaders())
        var result: LoadProductRegisteredByAccount.Result?
        
        sut?.load(by: makeLoadProductRegisteredByAccountParams()) { result = $0 }
        sut = nil
        httpGetClientSpy.completeWithError(.noConnectivity)
        
        XCTAssertNil(result)
    }
}

extension RemoteLoadProductRegisteredByAccountTests {
    func makeSut(url: URL = makeURL(), authenticationHeaders: AuthenticationHeaders = makeAuthenticationHeaders()) -> (sut: RemoteLoadProductRegisteredByAccount, httpGetClientSpy: HttpGetClientSpy, authenticationHeaders: AuthenticationHeaders) {
        let httpGetClientSpy = HttpGetClientSpy()
        let sut = RemoteLoadProductRegisteredByAccount(url: url, httpClient: httpGetClientSpy, authenticationHeaders: authenticationHeaders)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpGetClientSpy)
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
