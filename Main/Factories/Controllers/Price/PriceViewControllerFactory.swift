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
    controller.loadProductRegisteredByAccount = loadProductRegisteredByAccountPresenter.loadProductRegisteredByAccount
    return controller
}
