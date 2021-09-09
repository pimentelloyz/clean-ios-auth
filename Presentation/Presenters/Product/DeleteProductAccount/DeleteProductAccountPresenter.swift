import Foundation
import Domain

public final class DeleteProductAccountPresenter {
    private let deleteProductAccount: DeleteProductAccount
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let viewModel: ResultNoContentViewModel
    
    public init(deleteProductAccount: DeleteProductAccount,
                alertView: AlertView,
                loadingView: LoadingView,
                viewModel: ResultNoContentViewModel) {
        self.deleteProductAccount = deleteProductAccount
        self.alertView = alertView
        self.loadingView = loadingView
        self.viewModel = viewModel
    }
    
    public func delete(to pathComponent: PathComponentRequest) {
       
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        self.deleteProductAccount.delete(to: pathComponent.toPathComponent()) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .failure(let error):
                switch error {
                case .expiredSession:
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Sessão expirada, faça login novamente"))
                default:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Ocorreu um erro, tente novamente dentro de alguns instantes"))
                }
            case .success(let data): self.viewModel.result(NoContentViewModel(data: data))
            }
        }
    }
}
