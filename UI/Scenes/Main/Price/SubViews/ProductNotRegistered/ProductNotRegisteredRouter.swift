import Foundation
import Presentation

public final class ProductNotRegisteredRouter {
    private let nav: NavigationController
    private let addProductViewControllerFactory: (LoadProductNotRegisteredByAccountBodyViewModel) -> AddProductViewController
    
    public init(nav: NavigationController, addProductViewControllerFactory: @escaping (LoadProductNotRegisteredByAccountBodyViewModel) -> AddProductViewController) {
        self.nav = nav
        self.addProductViewControllerFactory = addProductViewControllerFactory
    }

    public func goToAddProductViewController(viewModel: LoadProductNotRegisteredByAccountBodyViewModel) {
        nav.pushViewController(addProductViewControllerFactory(viewModel))
    }
}
