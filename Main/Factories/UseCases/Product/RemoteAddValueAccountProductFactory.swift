import Foundation
import Data
import Domain

func makeRemoteAddValueAccountProduct() -> AddValueAccountProduct {
    return makeRemoteAddValueAccountProductWith(httpClient: makeAlamofirePostAdapter())
}

func makeRemoteAddValueAccountProductWith(httpClient: HttpPostClient) -> AddValueAccountProduct {
    let addValueAccountProduct = RemoteAddValueAccountProduct(url: makeApiUrl(path: "product/add-value-account-product"), httpClient: httpClient,  authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(addValueAccountProduct)
}
