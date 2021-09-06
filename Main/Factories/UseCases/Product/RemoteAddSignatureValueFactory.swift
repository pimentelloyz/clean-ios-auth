import Foundation
import Data
import Domain

func makeRemoteAddSignatureValue() -> AddSignatureValue {
    return makeRemoteAddSignatureValueWith(httpClient: makeAlamofirePostAdapter())
}

func makeRemoteAddSignatureValueWith(httpClient: HttpPostClient) -> AddSignatureValue {
    let addSignatureValue = RemoteAddSignatureValue(url: makeApiUrl(path: "product/add-signature-value"), httpClient: httpClient,  authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(addSignatureValue)
}
