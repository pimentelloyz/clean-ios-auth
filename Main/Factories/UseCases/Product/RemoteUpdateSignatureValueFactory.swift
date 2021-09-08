import Foundation
import Data
import Domain

func makeRemoteUpdateSignatureValue() -> UpdateSignatureValue {
    return makeRemoteUpdateSignatureValueWith(httpClient: makeAlamofirePutAdapter())
}

func makeRemoteUpdateSignatureValueWith(httpClient: HttpPutClient) -> UpdateSignatureValue {
    let module = RemoteUpdateSignatureValue(url: makeApiUrl(path: "product/update-signature-value"), httpClient: httpClient, authenticationHeaders: makeAuthenticationHeaders())
    return MainQueueDispatchDecorator(module)
}
