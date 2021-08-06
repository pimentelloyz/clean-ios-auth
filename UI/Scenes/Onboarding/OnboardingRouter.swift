import Foundation

public final class OnboardingRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController

    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
    }

    public func goToLogin() {
        nav.pushViewController(loginFactory())
    }
}
