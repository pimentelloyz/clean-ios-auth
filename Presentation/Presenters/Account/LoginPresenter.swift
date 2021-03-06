import Foundation
import Domain

public final class LoginPresenter {
    private let alertView: AlertView
    private let authentication: Authentication
    private let loadingView: LoadingView
    private let authenticationResultViewModel: AuthenticationResultViewModel
    
    public init(alertView: AlertView,
                authentication: Authentication,
                loadingView: LoadingView,
                authenticationResultViewModel: AuthenticationResultViewModel) {
        self.alertView = alertView
        self.authentication = authentication
        self.loadingView = loadingView
        self.authenticationResultViewModel = authenticationResultViewModel
    }
    
    public func signIn() {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        authentication.auth() { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .failure(let error):
                switch error {
                case .expiredSession:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Invalid email and / or password (s)"))
                default:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "An error occurred, please try again in a few moments"))
                }
            case .success(let data):
                self.authenticationResultViewModel.result(AuthenticationViewModel(account: data))
            }
        }
    }
}
