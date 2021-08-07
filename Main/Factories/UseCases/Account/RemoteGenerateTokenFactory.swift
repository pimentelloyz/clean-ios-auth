import Foundation
import Data
import Domain

func makeRemoteGenerateToken() -> GenerateToken {
    return makeRemoteGenerateTokenWith(httpClient: makeAlamofirePostAdapter())
}

func makeRemoteGenerateTokenWith(httpClient: HttpPostClient) -> GenerateToken {
    let authentication = RemoteGenerateToken(url: makeApiUrl(path: "load-account-by-email"), httpClient: httpClient)
    return MainQueueDispatchDecorator(authentication)
}
