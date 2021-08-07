import Foundation
import Domain

public protocol GenerateTokenResultViewModel {
    func result(viewModel: GenerateTokenViewModel)
}

public struct GenerateTokenViewModel: Equatable {
    public var account: AccountModel
    
    public init(account: AccountModel) {
        self.account = account
    }
    
    public var isLogged: Bool {
        return !self.account.body.accessToken.isEmpty
    }
}
