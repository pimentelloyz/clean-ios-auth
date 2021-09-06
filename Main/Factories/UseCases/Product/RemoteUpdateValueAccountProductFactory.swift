import Foundation
import Data
import Domain

func makeRemoteLoadPost() -> UpdateValueAccountProduct {
    return makeRemoteUpdateValueAccountProductWith(httpClient: makeAlamofirePutAdapter())
}

func makeRemoteUpdateValueAccountProductWith(httpClient: HttpPutClient) -> UpdateValueAccountProduct {
    let module = RemoteUpdateValueAccountProduct(url: makeApiUrl(path: "product/update-signature-value"), httpClient: httpClient, authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(module)
}
