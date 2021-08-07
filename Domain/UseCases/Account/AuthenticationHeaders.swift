import Foundation

public struct AuthenticationHeaders: Model {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}
