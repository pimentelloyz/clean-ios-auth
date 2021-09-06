import Foundation
import Domain

public final class AddValueAccountProductPresenter {
    private let alertView: AlertView
    private let addValueAccountProduct: AddValueAccountProduct
    private let loadingView: LoadingView
    private let validation: Validation
    private let viewModel: ResultNoContentViewModel

    public init(alertView: AlertView,
                addValueAccountProduct: AddValueAccountProduct,
                loadingView: LoadingView,
                validation: Validation,
                viewModel: ResultNoContentViewModel) {
        self.alertView              = alertView
        self.addValueAccountProduct = addValueAccountProduct
        self.loadingView            = loadingView
        self.validation             = validation
        self.viewModel              = viewModel
    }
    
    public func add(request: AddValueAccountProductRequest) {
        if let message = validation.validate(data: request.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            addValueAccountProduct.add(with: request.toAddValueAccountProductParameters()) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure(let error):
                    switch error {
                    case .expiredSession:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Token expirado, faça login novamente"))
                    default:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Ocorreu um erro, tente novamente dentro de alguns instantes"))
                    }
                case .success(let data):
                    self.viewModel.result(NoContentViewModel(data: data))
                }
            }
        }
    }
}
