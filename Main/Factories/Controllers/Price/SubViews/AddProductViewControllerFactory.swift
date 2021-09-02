import Foundation
import Presentation
import Validation
import Domain

public func makeAddProductViewController() -> AddProductViewController {
    return makeAddProductViewControllerWith()
}

public func makeAddProductViewControllerWith() -> AddProductViewController {
    let controller = AddProductViewController.instantiate()
    return controller
}
