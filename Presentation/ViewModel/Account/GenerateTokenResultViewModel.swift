import Foundation
import Domain

public protocol GenerateTokenResultViewModel {
    func result(_ viewModel: GenerateTokenViewModel)
}

public struct GenerateTokenViewModel: Equatable {
    public var account: AccountModel?
    
    public init(account: AccountModel?) {
        self.account = account
    }
    
    public var isLogged: Bool {
        return self.account != nil
    }
}
