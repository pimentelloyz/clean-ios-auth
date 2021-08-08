import Foundation
import GoogleSignIn
import FirebaseAuth
import Firebase
import Data

public final class GoogleAuthAdapter: SocialSignIn {
    private let auth: Auth
    private let controller: UIViewController
    public init(auth: Auth = Auth.auth(), controller: UIViewController) {
        self.auth = auth
        self.controller = controller
    }
    
    public func signIn(completion: @escaping (Result<Data?, HttpError>) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.signIn(with: config, presenting: controller) { [weak self] user, error in
            guard let self = self else {
                completion(.failure(.badRequest))
                return
            }
          if let _ = error {
            completion(.failure(.badRequest))
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            completion(.failure(.badRequest))
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            self.auth.signIn(with: credential) { result, error in
                if let _ = error {
                    completion(.failure(.unauthorized))
                }
                if let result = result {
                    completion(.success(firebaseToValidData(user: result.user)))
                }
                completion(.failure(.badRequest))
            }
        }
    }
}
