import Foundation
import UIKit

public final class LoadScreenRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    private let mainFactory: () -> UITabBarController

    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController, mainFactory: @escaping () -> UITabBarController) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.mainFactory = mainFactory
    }

    public func goToLogin() {
        nav.pushViewController(loginFactory())
    }
    
    public func goToMain() {
        nav.setRootViewController(mainFactory())
    }
}
