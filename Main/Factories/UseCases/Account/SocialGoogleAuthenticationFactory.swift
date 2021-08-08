import Foundation
import Data
import Domain
import UIKit

func makeSocialGoogleAuthentication(controller: UIViewController) -> Authentication {
    return makeSocialGoogleAuthenticationWith(socialSignIn: makeGoogleAuthAdapterAdapter(controller: controller))
}

func makeSocialGoogleAuthenticationWith(socialSignIn: SocialSignIn) -> Authentication {
    let authentication = SocialAuthentication(socialSignIn: socialSignIn)
    return MainQueueDispatchDecorator(authentication)
}
