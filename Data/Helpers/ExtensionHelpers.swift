import Foundation
import Domain

public extension Data {
    func toModel<T: Codable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func toJson() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }
    
    func toHeaders() -> [String: String]? {
        if let authenticationHeader: AuthenticationHeaders = self.toModel() {
            let headers: [String: String] = [
                "Authorization": authenticationHeader.token
            ]
            return headers
        } else {
            return nil
        }
    }
}
