import Foundation

public struct AccountModel: Model {
    public let body: AccountModelBody
    
    public init(body: AccountModelBody) {
        self.body = body
    }
}

public struct AccountModelBody: Model {
    public let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
