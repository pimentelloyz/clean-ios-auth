import Foundation
import Domain

class GenerateTokenSpy: GenerateToken {
    var generateTokenParameters: GenerateTokenParameters?
    var completion: ((GenerateToken.Result) -> Void)?
    
    func generate(by generateTokenParameters: GenerateTokenParameters, completion: @escaping (GenerateToken.Result) -> Void) {
        self.generateTokenParameters = generateTokenParameters
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        self.completion?(.failure(error))
    }
    
    func completeWithAccount(_ account: AccountModel) {
        self.completion?(.success(account))
    }
}
