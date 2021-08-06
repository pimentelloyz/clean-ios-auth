import Foundation
import UI
import Presentation
import Validation
import Domain

public func makeLoginController() -> LoginViewController {
    let controller = LoginViewController.instantiate()
    let signInFacebookPresenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: makeSocialAuthenticationWith(socialSignIn: makeFacebookAuthAdapter()), loadingView: WeakVarProxy(controller))
    let signInMicrosoftPresenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: makeSocialAuthenticationWith(socialSignIn: makeMicrosoftAuthAdapter()), loadingView: WeakVarProxy(controller))
    controller.signInWithFacebook = signInFacebookPresenter.signIn
    controller.signInWithMicrosoft = signInMicrosoftPresenter.signIn
    return controller
}
