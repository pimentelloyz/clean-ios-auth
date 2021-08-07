import Domain

func makeAuthenticationHeaders() -> AuthenticationHeaders {
    return AuthenticationHeaders(token: makeLoadSecureCurrentAccountFactory().load()?.body.accessToken ?? "")
}
