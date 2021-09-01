import Foundation
import Data
import Domain

func makeRemoteLoadProductRegisteredByAccount() -> LoadProductRegisteredByAccount {
    return makeRemoteLoadProductRegisteredByAccountWith(httpClient: makeAlamofireGetAdapter())
}

func makeRemoteLoadProductRegisteredByAccountWith(httpClient: HttpGetClient) -> LoadProductRegisteredByAccount {
    let loadProduct = RemoteLoadProductRegisteredByAccount(url: makeApiUrl(path: "load-product-registered-by-account"), httpClient: httpClient, authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(loadProduct)
}
