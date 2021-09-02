import Foundation
import Presentation
import Validation
import Domain

public func makeAddProductViewController(viewModel: LoadProductNotRegisteredByAccountBodyViewModel) -> AddProductViewController {
    return makeAddProductViewControllerWith(viewModel: viewModel)
}

public func makeAddProductViewControllerWith(viewModel: LoadProductNotRegisteredByAccountBodyViewModel) -> AddProductViewController {
    let controller = AddProductViewController.instantiate()
    controller.productViewModel = viewModel
    return controller
}
