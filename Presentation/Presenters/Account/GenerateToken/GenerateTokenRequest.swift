import Foundation
import Domain

public struct GenerateTokenRequest: Model {
    public var email: String?
    
    public init (email: String? = nil) {
        self.email = email
    }
    
    public func toParameters() -> GenerateTokenParameters {
        return GenerateTokenParameters(email: self.email!)
    }
}
