import Foundation

public protocol AddValueAccountProduct {
    typealias Result = Swift.Result<NoContentModel, DomainError>
    func add(with params: AddValueAccountProductParameters, completion: @escaping (Result) -> Void)
}

public struct AddValueAccountProductParameters: Model {
    public let productId: Int
    public let salesValue: Double?
    
    public init(productId: Int,
                salesValue: Double?) {
        self.productId = productId
        self.salesValue  = salesValue
    }
}
