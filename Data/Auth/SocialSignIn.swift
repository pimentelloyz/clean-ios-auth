import Foundation

public protocol SocialSignIn {
    func signIn(completion: @escaping (Result<Data?, HttpError>) -> Void)
}
