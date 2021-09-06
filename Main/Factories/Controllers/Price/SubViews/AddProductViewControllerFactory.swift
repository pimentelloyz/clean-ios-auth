import Foundation
import Presentation
import Validation
import Domain

public func makeAddProductViewController(viewModel: LoadProductNotRegisteredByAccountBodyViewModel) -> AddProductViewController {
    return makeAddProductViewControllerWith(viewModel: viewModel, addValueAccountProduct: makeRemoteAddValueAccountProduct())
}

public func makeAddProductViewControllerWith(viewModel: LoadProductNotRegisteredByAccountBodyViewModel, addValueAccountProduct: AddValueAccountProduct) -> AddProductViewController {
    let controller = AddProductViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeAddValueAccountProductValidations())
    let presenter = AddValueAccountProductPresenter(alertView: WeakVarProxy(controller), addValueAccountProduct: addValueAccountProduct, loadingView: WeakVarProxy(controller), validation: validationComposite, viewModel: WeakVarProxy(controller))
    controller.productViewModel = viewModel
    controller.addValueAccountProduct = presenter.add
    return controller
}

public func makeAddValueAccountProductValidations() -> [Validation] {
    return ValidationBuilder.field("productId").label("PRODUCT_ID".localized()).required().build() +
        ValidationBuilder.field("salesValue").label("SALES_VALUE".localized()).required().build()
}
