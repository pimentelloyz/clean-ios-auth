import Foundation

public protocol LoadProductRegisteredByAccount {
    typealias Result = Swift.Result<ProductRegisteredByAccount, DomainError>
    func load(by params: LoadProductRegisteredParameters, completion: @escaping (Result) -> Void)
}

public struct LoadProductRegisteredParameters: Model {
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
