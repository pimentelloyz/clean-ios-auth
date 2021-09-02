import Foundation
import Data
import Domain

func makeRemoteLoadProductNotRegisteredByAccount() -> LoadProductNotRegisteredByAccount {
    return makeRemoteLoadProductNotRegisteredByAccountWith(httpClient: makeAlamofireGetAdapter())
}

func makeRemoteLoadProductNotRegisteredByAccountWith(httpClient: HttpGetClient) -> LoadProductNotRegisteredByAccount {
    let loadProduct = RemoteLoadProductNotRegisteredByAccount(url: makeApiUrl(path: "product/load-product-not-registered-by-account"), httpClient: httpClient, authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(loadProduct)
}
