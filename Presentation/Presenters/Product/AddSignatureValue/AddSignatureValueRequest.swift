import Foundation
import Domain

public struct AddSignatureValueRequest: Model {
    public let productId: Int?
    public let signatureItems: [SignatureItemsRequest]?
    
    public init(productId: Int? = nil,
                signatureItems: [SignatureItemsRequest]? = nil) {
        self.productId          = productId
        self.signatureItems     = signatureItems
    }
    
    public func toAddSignatureValueParameters() -> AddSignatureValueParameters {
        return AddSignatureValueParameters(productId: self.productId!, signatureItems: self.signatureItems!)
    }
}

public struct SignatureItemsRequest: Model {
    public let monthCount: Int
    public let salesValue: Double
    
    public init(monthCount: Int,
                salesValue: Double) {
        self.monthCount     = monthCount
        self.salesValue     = salesValue
    }
}
