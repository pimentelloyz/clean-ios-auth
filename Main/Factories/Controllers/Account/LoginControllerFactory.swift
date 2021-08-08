import Foundation
import UI
import Presentation
import Validation
import Domain

public func makeLoginController() -> LoginViewController {
    return makeLoginControllerWith(authentication: makeSocialAuthentication(), generateToken: makeRemoteGenerateToken())
}

public func makeLoginControllerWith(authentication: Authentication, generateToken: GenerateToken) -> LoginViewController {
    let controller = LoginViewController.instantiate()
    let signInFacebookPresenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: authentication, loadingView: WeakVarProxy(controller), authenticationResultViewModel: WeakVarProxy(controller))
    let validationComposite = ValidationComposite(validations: makeGenerateTokenValidations())
    let generateTokenPresenter = GenerateTokenPresenter(generateToken: generateToken, saveSecureCurrentAccount: makeSaveSecureCurrentAccountFactory(), generateTokenViewModel: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), validation: validationComposite, alertView: WeakVarProxy(controller))
    controller.signInWithFacebook = signInFacebookPresenter.signIn
    controller.generateToken = generateTokenPresenter.generate
    return controller
}

public func makeGenerateTokenValidations() -> [Validation] {
    return ValidationBuilder.field("email").label("Email").required().isEmail().build()
}
