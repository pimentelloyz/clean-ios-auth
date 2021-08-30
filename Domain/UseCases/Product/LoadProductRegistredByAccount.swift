import Foundation

public protocol LoadProductRegistredByAccount {
    typealias Result = Swift.Result<ProductRegisterdByAccount, DomainError>
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
