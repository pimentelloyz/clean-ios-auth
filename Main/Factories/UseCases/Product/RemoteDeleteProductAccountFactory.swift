import Foundation
import Data
import Domain

func makeRemoteDeleteProductAccount() -> DeleteProductAccount {
    return makeRemoteDeleteProductAccountWith(httpClient: makeAlamofireDeleteAdapter())
}

func makeRemoteDeleteProductAccountWith(httpClient: HttpDeleteClient) -> DeleteProductAccount {
    let deleteProductAccount = RemoteDeleteProductAccount(url: makeApiUrl(path: "product/product-account"), httpClient: httpClient, authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(deleteProductAccount)
}
