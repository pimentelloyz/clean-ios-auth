import Domain

public final class LoadProductNotRegisteredByAccountPresenter {
    private let loadProductNotRegisteredByAccount: LoadProductNotRegisteredByAccount
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let viewModel: LoadProductNotRegisteredByAccountResultViewModel
    
    public init(loadProductNotRegisteredByAccount: LoadProductNotRegisteredByAccount,
                alertView: AlertView,
                loadingView: LoadingView,
                viewModel: LoadProductNotRegisteredByAccountResultViewModel) {
        self.loadProductNotRegisteredByAccount = loadProductNotRegisteredByAccount
        self.alertView = alertView
        self.loadingView = loadingView
        self.viewModel = viewModel
    }
    
    public func loadProductNotRegisteredByAccount(request: LoadProductNotRegisteredByAccountRequest) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        loadProductNotRegisteredByAccount.load(by: request.toPostParams()) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .failure(let error):
            switch error {
            case .expiredSession:
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Sessão expirada, faça login novamente"))
            default: self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Ocorreu um erro, tente novamente dentro de alguns instantes"))
            }
            case .success(let data): self.viewModel.result(LoadProductNotRegisteredByAccountViewModel(product: data))
            }
        }
    }
}
