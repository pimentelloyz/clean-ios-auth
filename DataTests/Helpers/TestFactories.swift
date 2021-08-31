import Foundation
import Domain

func makeAuthenticationHeaders() -> AuthenticationHeaders {
    return AuthenticationHeaders(token: "any-token")
}

func makeInvalidData() -> Data {
    return Data("invalid-data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"any-value\"}".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
