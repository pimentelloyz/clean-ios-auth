import Foundation

public protocol LoadProductNotRegisteredByAccount {
    typealias Result = Swift.Result<ProductNotRegisteredByAccount, DomainError>
    func load(by params: LoadProductNotRegisteredByAccountParameters, completion: @escaping (Result) -> Void)
}

public struct LoadProductNotRegisteredByAccountParameters: Model {
    public let offset: Int
    public let limit: Int
    public let search: String
    
    public init(offset: Int,
                limit: Int,
                search: String) {
        self.offset = offset
        self.limit  = limit
        self.search = search
    }
}
