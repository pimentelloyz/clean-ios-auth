import Foundation
import Domain

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}

func makeAuthenticationHeaders() -> AuthenticationHeaders {
    return AuthenticationHeaders(token: "any-token")
}
