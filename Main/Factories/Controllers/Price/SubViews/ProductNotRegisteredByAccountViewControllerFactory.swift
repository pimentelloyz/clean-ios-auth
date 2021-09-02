import Foundation
import Presentation
import Validation
import Domain

public func makeProductNotRegisteredViewController() -> ProductNotRegisteredViewController {
    return makeProductNotRegisteredViewControllerWith(loadProductNotRegisteredByAccount: makeRemoteLoadProductNotRegisteredByAccount())
}

public func makeProductNotRegisteredViewControllerWith(loadProductNotRegisteredByAccount: LoadProductNotRegisteredByAccount) -> ProductNotRegisteredViewController {
    let controller = ProductNotRegisteredViewController.instantiate()
    let loadProductNotRegisteredByAccountPresenter = LoadProductNotRegisteredByAccountPresenter(loadProductNotRegisteredByAccount: loadProductNotRegisteredByAccount, alertView: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), viewModel: WeakVarProxy(controller))
    let productNotRegisteredRouter = ProductNotRegisteredRouter(nav: SceneDelegate.nav, addProductViewControllerFactory: makeAddProductViewController)
    controller.loadProductNotRegisteredByAccount = loadProductNotRegisteredByAccountPresenter.loadProductNotRegisteredByAccount
    controller.goToAddProductViewController = productNotRegisteredRouter.goToAddProductViewController
    return controller
}
