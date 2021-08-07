import Foundation
import Data
import Domain

func makeRemoteRefreshToken() -> RefreshToken {
    return makeRemoteRefreshTokenWith(httpClient: makeAlamofireGetAdapter())
}

func makeRemoteRefreshTokenWith(httpClient: HttpGetClient) -> RefreshToken {
    let authentication = RemoteRefreshToken(url: makeApiUrl(path: "signin/refresh"), httpClient: httpClient, authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(authentication)
}
