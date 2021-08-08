import Foundation
import Domain

public final class SocialAuthentication: Authentication {
    public var socialSignIn: SocialSignIn
    
    public init(socialSignIn: SocialSignIn) {
        self.socialSignIn = socialSignIn
    }
    
    public func auth(completion: @escaping (Authentication.Result) -> Void) {
        socialSignIn.signIn { result in
            switch result {
            case .failure: completion(.failure(.unexpected))
            case .success(let data):
                if let data: AuthenticationModel = data?.toModel() {
                    completion(.success(data))
                }
                completion(.failure(.unexpected))
            }
        }
    }
}
