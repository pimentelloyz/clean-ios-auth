import Foundation
import Data
import Domain

func makeSocialMicrosoftAuthentication() -> Authentication {
    return makeSocialMicrosoftAuthenticationWith(socialSignIn: makeMicrosoftAuthAdapter())
}

func makeSocialMicrosoftAuthenticationWith(socialSignIn: SocialSignIn) -> Authentication {
    let authentication = SocialAuthentication(socialSignIn: socialSignIn)
    return MainQueueDispatchDecorator(authentication)
}
