import Foundation
import UIKit

public final class LoginRouter {
    private let nav: NavigationController
    private let mainFactory: () -> UITabBarController
    
    public init(nav: NavigationController, mainFactory: @escaping () -> UITabBarController) {
        self.nav = nav
        self.mainFactory = mainFactory
    }
    
    public func goToMain() {
        nav.setRootViewController(mainFactory())
    }
}
