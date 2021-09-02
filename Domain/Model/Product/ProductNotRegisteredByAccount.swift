import Foundation

public struct ProductNotRegisteredByAccount: Model {
    public let body: [ProductNotRegisteredByAccountBody]
   
    public init(body: [ProductNotRegisteredByAccountBody]) {
        self.body = body
    }
}

public struct ProductNotRegisteredByAccountBody: Model {
    public let productId: Int
    public let productCode: String
    public let productName: String
    public let productSignature: Bool
    public let salesValue: Double?
    public let lastPurchasePrice: Double?
    
    public init(productId: Int,
                productCode: String,
                productName: String,
                productSignature: Bool,
                salesValue: Double?,
                lastPurchasePrice: Double?) {
        self.productId          = productId
        self.productCode        = productCode
        self.productName        = productName
        self.productSignature   = productSignature
        self.salesValue         = salesValue
        self.lastPurchasePrice  = lastPurchasePrice
    }
}
