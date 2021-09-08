import Foundation
import Presentation
import Validation
import Domain

public func makeAddProductViewController(viewModel: LoadProductNotRegisteredByAccountBodyViewModel) -> AddProductViewController {
    return makeAddProductViewControllerWith(viewModel: viewModel, addValueAccountProduct: makeRemoteAddValueAccountProduct(), addSignatureValue: makeRemoteAddSignatureValue())
}

public func makeAddProductViewController(viewModel: LoadProductRegisteredByAccountBodyViewModel) -> AddProductViewController {
    return makeUpdateProductViewControllerWith(viewModel: viewModel, updateValueAccountProduct: makeRemoteUpdateValueAccountProduct())
}


public func makeAddProductViewControllerWith(viewModel: LoadProductNotRegisteredByAccountBodyViewModel, addValueAccountProduct: AddValueAccountProduct, addSignatureValue: AddSignatureValue) -> AddProductViewController {
    let controller = AddProductViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeAddValueAccountProductValidations())
    let validationCompositeToSignatureValue = ValidationComposite(validations: makeAddSignatureValuesValidations())
    let addValueAccountProductPresenter = AddValueAccountProductPresenter(alertView: WeakVarProxy(controller), addValueAccountProduct: addValueAccountProduct, loadingView: WeakVarProxy(controller), validation: validationComposite, viewModel: WeakVarProxy(controller))
    let addSignatureValuePresenter = AddSignatureValuePresenter(alertView: WeakVarProxy(controller), addSignatureValue: addSignatureValue, loadingView: WeakVarProxy(controller), validation: validationCompositeToSignatureValue, viewModel: WeakVarProxy(controller))
    controller.productViewModel = viewModel
    controller.addValueAccountProduct = addValueAccountProductPresenter.add
    controller.addSignatureValue = addSignatureValuePresenter.add
    return controller
}

public func makeUpdateProductViewControllerWith(viewModel: LoadProductRegisteredByAccountBodyViewModel, updateValueAccountProduct: UpdateValueAccountProduct) -> AddProductViewController {
    let controller = AddProductViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeAddValueAccountProductValidations())
    let updateValueAccountProductPresenter = UpdateValueAccountProductPresenter(updateValueAccountProduct: updateValueAccountProduct, alertView: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), validation: validationComposite, viewModel: WeakVarProxy(controller))
    controller.productToEditViewModel = viewModel
    controller.productActionManager = .update
    controller.updateValueAccountProduct = updateValueAccountProductPresenter.update
    return controller
}

public func makeAddValueAccountProductValidations() -> [Validation] {
    return ValidationBuilder.field("productId").label("PRODUCT_ID".localized()).required().build() +
        ValidationBuilder.field("salesValue").label("SALES_VALUE".localized()).required().build()
}

public func makeAddSignatureValuesValidations() -> [Validation] {
    return ValidationBuilder.field("productId").label("PRODUCT_ID".localized()).required().build() +
        ValidationBuilder.field("signatureItems").label("SIGNATURE_ITENS".localized()).required().build()
}
