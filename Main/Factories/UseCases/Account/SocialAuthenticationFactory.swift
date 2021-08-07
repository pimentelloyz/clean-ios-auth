import Foundation
import Data
import Domain

func makeSocialAuthentication() -> Authentication {
    return makeSocialAuthenticationWith(socialSignIn: makeFacebookAuthAdapter())
}

func makeSocialAuthenticationWith(socialSignIn: SocialSignIn) -> Authentication {
    let authentication = SocialAuthentication(socialSignIn: socialSignIn)
    return MainQueueDispatchDecorator(authentication)
}
