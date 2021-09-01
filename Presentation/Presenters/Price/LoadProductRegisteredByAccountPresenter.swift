import Domain

public final class LoadProductRegisteredByAccountPresenter {
    private let loadProductRegisteredByAccount: LoadProductRegisteredByAccount
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let viewModel: LoadProductRegisteredByAccountResultViewModel
    
    public init(loadProductRegisteredByAccount: LoadProductRegisteredByAccount,
                alertView: AlertView,
                loadingView: LoadingView,
                viewModel: LoadProductRegisteredByAccountResultViewModel) {
        self.loadProductRegisteredByAccount = loadProductRegisteredByAccount
        self.alertView = alertView
        self.loadingView = loadingView
        self.viewModel = viewModel
    }
    
    public func loadProductRegisteredByAccount(request: LoadProductRegisteredByAccountRequest) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        loadProductRegisteredByAccount.load(by: request.toPostParams()) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .failure(let error):
            switch error {
            case .expiredSession:
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Sessão expirada, faça login novamente"))
            default: self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Ocorreu um erro, tente novamente dentro de alguns instantes"))
            }
            case .success(let data): self.viewModel.result(LoadProductRegisteredByAccountViewModel(product: data))
            }
        }
    }
}
