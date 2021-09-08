import Foundation
import Data
import Domain

func makeRemoteUpdateValueAccountProduct() -> UpdateValueAccountProduct {
    return makeRemoteUpdateValueAccountProductWith(httpClient: makeAlamofirePutAdapter())
}

func makeRemoteUpdateValueAccountProductWith(httpClient: HttpPutClient) -> UpdateValueAccountProduct {
    let module = RemoteUpdateValueAccountProduct(url: makeApiUrl(path: "product/update-value-account-product"), httpClient: httpClient, authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(module)
}
