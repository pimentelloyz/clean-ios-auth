import Foundation
import UI
import Presentation
import Validation
import Domain

public func makeLoginController() -> LoginViewController {
    return makeLoginControllerWith(facebookAuthentication: makeSocialFacebookAuthentication(), microsoftAuthentication: makeSocialMicrosoftAuthentication(), generateToken: makeRemoteGenerateToken())
}

public func makeLoginControllerWith(facebookAuthentication: Authentication, microsoftAuthentication: Authentication, generateToken: GenerateToken) -> LoginViewController {
    let controller = LoginViewController.instantiate()
    let loginRouter = LoginRouter(nav: SceneDelegate.nav, mainFactory: makeMainTabBarController)
    let signInFacebookPresenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: facebookAuthentication, loadingView: WeakVarProxy(controller), authenticationResultViewModel: WeakVarProxy(controller))
    let signInMicrosoftPresenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: microsoftAuthentication, loadingView: WeakVarProxy(controller), authenticationResultViewModel: WeakVarProxy(controller))
    let signInGooglePresenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: makeSocialGoogleAuthentication(controller: controller), loadingView: WeakVarProxy(controller), authenticationResultViewModel: WeakVarProxy(controller))
    let validationComposite = ValidationComposite(validations: makeGenerateTokenValidations())
    let generateTokenPresenter = GenerateTokenPresenter(generateToken: generateToken, saveSecureCurrentAccount: makeSaveSecureCurrentAccountFactory(), generateTokenViewModel: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), validation: validationComposite, alertView: WeakVarProxy(controller))
    controller.signInWithFacebook = signInFacebookPresenter.signIn
    controller.signInWithGoogle = signInGooglePresenter.signIn
    controller.generateToken = generateTokenPresenter.generate
    controller.signInWithMicrosoft = signInMicrosoftPresenter.signIn
    controller.goToMain = loginRouter.goToMain
    return controller
}

public func makeGenerateTokenValidations() -> [Validation] {
    return ValidationBuilder.field("email").label("Email").required().isEmail().build()
}
