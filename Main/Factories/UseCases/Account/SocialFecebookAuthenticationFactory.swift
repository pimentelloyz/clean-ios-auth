import Foundation
import Data
import Domain

func makeSocialFacebookAuthentication() -> Authentication {
    return makeSocialFacebookAuthenticationWith(socialSignIn: makeFacebookAuthAdapter())
}

func makeSocialFacebookAuthenticationWith(socialSignIn: SocialSignIn) -> Authentication {
    let authentication = SocialAuthentication(socialSignIn: socialSignIn)
    return MainQueueDispatchDecorator(authentication)
}
