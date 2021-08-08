import Foundation
import Domain

public protocol AuthenticationResultViewModel {
    func result(_ viewModel: AuthenticationViewModel)
}

public struct AuthenticationViewModel: Equatable {
    public let account: AuthenticationModel?
    
    public init(account: AuthenticationModel?) {
        self.account = account
    }
}
