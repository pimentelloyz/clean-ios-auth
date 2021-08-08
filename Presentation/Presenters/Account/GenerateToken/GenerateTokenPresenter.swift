import Foundation
import Domain

public final class GenerateTokenPresenter {
    private let generateToken: GenerateToken
    private let saveSecureCurrentAccount: SaveSecureCurrentAccount
    private let generateTokenViewModel: GenerateTokenResultViewModel
    private let loadingView: LoadingView
    private let validation: Validation
    private let alertView: AlertView
    
    public init(generateToken: GenerateToken,
                saveSecureCurrentAccount: SaveSecureCurrentAccount,
                generateTokenViewModel: GenerateTokenResultViewModel,
                loadingView: LoadingView,
                validation: Validation,
                alertView: AlertView) {
        self.generateToken = generateToken
        self.saveSecureCurrentAccount = saveSecureCurrentAccount
        self.generateTokenViewModel = generateTokenViewModel
        self.loadingView = loadingView
        self.validation = validation
        self.alertView = alertView
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
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Você não tem acesso ao sistema"))
                    default:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Ocorreu um erro, tente novamente dentro de alguns instantes"))
                    }
                case .success(let data):
                    self.saveSecureCurrentAccount.save(account: data)
                    self.generateTokenViewModel.result(GenerateTokenViewModel(account: data))
                }
            }
        }
    }
}
