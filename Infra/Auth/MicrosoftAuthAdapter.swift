import Foundation
import MSAL
import FirebaseAuth
import Data

public final class MicrosoftAuthAdapter: SocialSignIn {
    private let provider: OAuthProvider
    private let auth: Auth
    public init(provider: OAuthProvider = OAuthProvider(providerID: "microsoft.com"), auth: Auth = Auth.auth()) {
        self.provider = provider
        self.auth = auth
    }
    
    public func signIn(completion: @escaping (Result<Data?, HttpError>) -> Void) {
        provider.customParameters = [
            "prompt": "consent",
        ]
        provider.customParameters = [
            "tenant": "dd96d260-3452-40bd-99cc-36cd589a4bc0"
        ]
        provider.scopes = ["user.read"]
        provider.getCredentialWith(nil) { credential, error in
            if error != nil {
                completion(.failure(.badRequest))
            }
            if let credential = credential {
                self.auth.signIn(with: credential) { result, error in
                    if let result = result {
                        completion(.success(firebaseToValidData(user: result.user)))
                    }
                    if let _ = error {
                        completion(.failure(.unauthorized))
                    }
                    
                    completion(.failure(.badRequest))
                }
            }
        }
    }
}
