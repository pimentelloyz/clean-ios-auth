import Foundation
import Domain

public final class AddSignatureValuePresenter {
    private let alertView: AlertView
    private let addSignatureValue: AddSignatureValue
    private let loadingView: LoadingView
    private let validation: Validation
    private let viewModel: ResultNoContentViewModel

    public init(alertView: AlertView,
                addSignatureValue: AddSignatureValue,
                loadingView: LoadingView,
                validation: Validation,
                viewModel: ResultNoContentViewModel) {
        self.alertView              = alertView
        self.addSignatureValue      = addSignatureValue
        self.loadingView            = loadingView
        self.validation             = validation
        self.viewModel              = viewModel
    }
    
    public func add(request: AddSignatureValueRequest) {
        if let message = validation.validate(data: request.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "VALIDATION_FAILS", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            addSignatureValue.add(with: request.toAddSignatureValueParameters()) { [weak self] result in
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
