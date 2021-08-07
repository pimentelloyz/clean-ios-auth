import Foundation
import Domain

public protocol LocalCurrentAccountResultViewModel {
    func result(_ viewModel: LocalCurrentAccounViewModel)
}

public struct LocalCurrentAccounViewModel: Equatable {
    public let account: AccountModel?
    
    public init(account: AccountModel?) {
        self.account = account
    }
}
