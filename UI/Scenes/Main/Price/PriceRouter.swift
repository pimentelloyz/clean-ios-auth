import Foundation
import Presentation

public final class PriceRouter {
    private let nav: NavigationController
    private let productNotRegisteredViewControllerFactory: () -> ProductNotRegisteredViewController
    private let addProductViewControllerFactory: (LoadProductRegisteredByAccountBodyViewModel) -> AddProductViewController
    
    public init(nav: NavigationController, productNotRegisteredViewControllerFactory: @escaping () -> ProductNotRegisteredViewController, addProductViewControllerFactory: @escaping (LoadProductRegisteredByAccountBodyViewModel) -> AddProductViewController) {
        self.nav = nav
        self.productNotRegisteredViewControllerFactory = productNotRegisteredViewControllerFactory
        self.addProductViewControllerFactory = addProductViewControllerFactory

    }

    public func goToProductNotRegisteredViewController() {
        nav.pushViewController(productNotRegisteredViewControllerFactory())
    }
    
    public func goToAddProductViewController(viewModel: LoadProductRegisteredByAccountBodyViewModel) {
        nav.pushViewController(addProductViewControllerFactory(viewModel))
    }
}
