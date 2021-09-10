import Foundation
import Domain

public struct AddValueAccountProductRequest: Model {
    public let productId: Int?
    public let salesValue: Double?
    
    public init(productId: Int? = nil,
                salesValue: Double? = nil) {
        self.productId = productId
        self.salesValue  = salesValue
    }
    
    public func toAddValueAccountProductParameters() -> AddValueAccountProductParameters {
        return AddValueAccountProductParameters(productId: self.productId!, salesValue: self.salesValue)
    }
}
