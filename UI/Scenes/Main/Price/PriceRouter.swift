import Foundation

public final class PriceRouter {
    private let nav: NavigationController
    private let productNotRegisteredViewControllerFactory: () -> ProductNotRegisteredViewController
    
    public init(nav: NavigationController, productNotRegisteredViewControllerFactory: @escaping () -> ProductNotRegisteredViewController) {
        self.nav = nav
        self.productNotRegisteredViewControllerFactory = productNotRegisteredViewControllerFactory
    }

    public func goToProductNotRegisteredViewController() {
        nav.pushViewController(productNotRegisteredViewControllerFactory())
    }
}
