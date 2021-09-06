import Domain

public final class UpdateValueAccountProductPresenter {
    private let updateValueAccountProduct: UpdateValueAccountProduct
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let viewModel: ResultNoContentViewModel
    
    public init(updateValueAccountProduct: UpdateValueAccountProduct,
                alertView: AlertView,
                loadingView: LoadingView,
                viewModel: ResultNoContentViewModel) {
        self.updateValueAccountProduct = updateValueAccountProduct
        self.alertView = alertView
        self.loadingView = loadingView
        self.viewModel = viewModel
    }
    
    public func update(request: UpdateValueAccountProductRequest, and pathComponent: PathComponentRequest) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        updateValueAccountProduct.update(by: request.toUpdateValueAccountProductParameters(), to: pathComponent.toPathComponent()) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .failure(let error):
            switch error {
            case .expiredSession:
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Sessão expirada, faça login novamente"))
            default: self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Ocorreu um erro, tente novamente dentro de alguns instantes"))
            }
            case .success(let data): self.viewModel.result(NoContentViewModel(data: data))
            }
        }
    }
}
