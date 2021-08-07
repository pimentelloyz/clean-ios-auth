import Foundation
import FacebookLogin
import FirebaseAuth
import Data

public final class FacebookAuthAdapter: SocialSignIn {
    private let loginManager: LoginManager
    private let auth: Auth
    public init(loginManager: LoginManager = LoginManager(), auth: Auth = Auth.auth()) {
        self.loginManager = loginManager
        self.auth = auth
    }
    
    public func signIn(completion: @escaping (Result<Data?, HttpError>) -> Void) {
        loginManager.logOut()
        loginManager.logIn(permissions: [.email]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(granted: _, declined: _, token: let token):
                guard let token = token else {
                    completion(.failure(.unauthorized))
                    return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                self.auth.signIn(with: credential) { result, error in
                    if let _ = error {
                        completion(.failure(.unauthorized))
                    }
                    completion(.success(nil))
                }
            case .failed( _):
                completion(.failure(.badRequest))
            case .cancelled:
                break
            }
        }
    }
}
