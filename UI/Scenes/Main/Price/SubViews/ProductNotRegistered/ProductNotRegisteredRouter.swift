import Foundation

public final class ProductNotRegisteredRouter {
    private let nav: NavigationController
    private let addProductViewControllerFactory: () -> AddProductViewController
    
    public init(nav: NavigationController, addProductViewControllerFactory: @escaping () -> AddProductViewController) {
        self.nav = nav
        self.addProductViewControllerFactory = addProductViewControllerFactory
    }

    public func goToAddProductViewController() {
        nav.pushViewController(addProductViewControllerFactory())
    }
}
