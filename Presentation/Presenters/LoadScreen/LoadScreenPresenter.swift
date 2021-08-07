import Domain

public final class LoadScreenPresenter {
    private let loadSecureCurrentAccount: LoadSecureCurrentAccount
    private let currentAccountViewModel: LocalCurrentAccountResultViewModel
    private let refreshToken: RefreshToken
    private let saveSecureCurrentAccount: SaveSecureCurrentAccount
    
    public init(loadSecureCurrentAccount: LoadSecureCurrentAccount,
                currentAccountViewModel: LocalCurrentAccountResultViewModel,
                refreshToken: RefreshToken,
                saveSecureCurrentAccount: SaveSecureCurrentAccount) {
        self.loadSecureCurrentAccount = loadSecureCurrentAccount
        self.currentAccountViewModel = currentAccountViewModel
        self.refreshToken = refreshToken
        self.saveSecureCurrentAccount = saveSecureCurrentAccount
    }
    
    public func checkAccount() {
        refreshToken.refresh { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .failure:
                let account = self?.loadSecureCurrentAccount.load()
                self?.currentAccountViewModel.result(LocalCurrentAccounViewModel(account: account))
            case .success(let accountModel):
                self?.saveSecureCurrentAccount.save(account: accountModel)
                let account = self?.loadSecureCurrentAccount.load()
                self?.currentAccountViewModel.result(LocalCurrentAccounViewModel(account: account))
            }
        }
    }
}
