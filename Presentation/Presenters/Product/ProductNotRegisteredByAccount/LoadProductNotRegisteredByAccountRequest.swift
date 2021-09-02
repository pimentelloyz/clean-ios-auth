import Foundation
import Domain

public struct LoadProductNotRegisteredByAccountRequest: Model {
    public let limit: Int
    public let offset: Int
    public let search: String
    
    public init(limit: Int,
                offSet: Int,
                search: String) {
        self.limit = limit
        self.offset = offSet
        self.search = search
    }
    
    public func toPostParams() -> LoadProductNotRegisteredByAccountParameters {
        return LoadProductNotRegisteredByAccountParameters(offset: offset, limit: limit, search: search)
    }
}
