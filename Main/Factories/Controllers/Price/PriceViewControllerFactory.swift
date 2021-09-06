import Foundation
import Presentation
import Validation
import Domain

public func makePriceViewController() -> PriceViewController {
    return makePriceViewControllerWith(loadProductRegisteredByAccount: makeRemoteLoadProductRegisteredByAccount())
}

public func makePriceViewControllerWith(loadProductRegisteredByAccount: LoadProductRegisteredByAccount) -> PriceViewController {
    let controller = PriceViewController.instantiate()
    let loadProductRegisteredByAccountPresenter = LoadProductRegisteredByAccountPresenter(loadProductRegisteredByAccount: loadProductRegisteredByAccount, alertView: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), viewModel: WeakVarProxy(controller))
    let priceRouter = PriceRouter(nav: SceneDelegate.nav, productNotRegisteredViewControllerFactory: makeProductNotRegisteredViewController, addProductViewControllerFactory: makeAddProductViewController)
    controller.loadProductRegisteredByAccount = loadProductRegisteredByAccountPresenter.loadProductRegisteredByAccount
    controller.goToProductNotRegisteredViewController = priceRouter.goToProductNotRegisteredViewController
    controller.goToAddProductViewController = priceRouter.goToAddProductViewController
    return controller
}
