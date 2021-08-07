import Foundation
import Domain

public final class GenerateTokenPresenter {
    private let alertView: AlertView
    private let generateToken: GenerateToken
    private let loadingView: LoadingView
    private let validation: Validation
    private let saveSecureCurrentAccount: SaveSecureCurrentAccount
    private let generateTokenViewModel: GenerateTokenResultViewModel
    
    public init(alertView: AlertView,
                generateToken: GenerateToken,
                loadingView: LoadingView,
                validation: Validation,
                saveSecureCurrentAccount: SaveSecureCurrentAccount,
                generateTokenViewModel: GenerateTokenResultViewModel) {
        self.alertView = alertView
        self.generateToken = generateToken
        self.loadingView = loadingView
        self.validation = validation
        self.saveSecureCurrentAccount = saveSecureCurrentAccount
        self.generateTokenViewModel = generateTokenViewModel
    }
    
    public func generate(request: GenerateTokenRequest) {
        if let message = validation.validate(data: request.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            generateToken.generate(by: request.toParameters()) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure(let error):
                    switch error {
                    case .expiredSession:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Email e/ou senha inválido(s)"))
                    case .unauthorized:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Voce ou sua igreja tem acesso a este módulo"))
                    default:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Ocorreu um erro, tente novamente dentro de alguns instantes"))
                    }
                case .success(let data):
                    self.saveSecureCurrentAccount.save(account: data)
                    self.generateTokenViewModel.result(viewModel: GenerateTokenViewModel(account: data))
                }
            }
        }
    }
}
