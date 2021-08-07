import Foundation
import Presentation
import Domain

public func makeLoadScreenController(nav: NavigationController) -> LoadScreenViewController {
    return makeLoadScreenControllerWith(nav: nav, refreshToken: makeRemoteRefreshToken())
}

public func makeLoadScreenControllerWith(nav: NavigationController, refreshToken: RefreshToken) -> LoadScreenViewController {
    let loadScreenViewController = LoadScreenViewController.instantiate()
    let loadScreenRouter = LoadScreenRouter(nav: SceneDelegate.nav, loginFactory: makeLoginController, mainFactory: makeMainTabBarController)
    let presenter = LoadScreenPresenter(loadSecureCurrentAccount: makeLoadSecureCurrentAccountFactory(), currentAccountViewModel: WeakVarProxy(loadScreenViewController), refreshToken: refreshToken, saveSecureCurrentAccount: makeSaveSecureCurrentAccountFactory())
    loadScreenViewController.checkAccount = presenter.checkAccount
    loadScreenViewController.goToMain = loadScreenRouter.goToMain
    loadScreenViewController.goToLogin = loadScreenRouter.goToLogin
    return loadScreenViewController
}
