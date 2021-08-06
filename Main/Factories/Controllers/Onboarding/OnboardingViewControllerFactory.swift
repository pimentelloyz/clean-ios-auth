import Foundation
import UI

public func makeOnboardingController(nav: NavigationController) -> OnboardingViewController {
    let onboardingRouter = OnboardingRouter(nav: nav, loginFactory: makeLoginController)
    let onboardingViewController = OnboardingViewController.instantiate()
    onboardingViewController.login = onboardingRouter.goToLogin
    return onboardingViewController
}
