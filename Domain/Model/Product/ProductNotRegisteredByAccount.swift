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
    public let accountProductId: Int?
    
    public init(productId: Int,
                productCode: String,
                productName: String,
                productSignature: Bool,
                salesValue: Double?,
                lastPurchasePrice: Double?,
                accountProductId: Int?) {
        self.productId          = productId
        self.productCode        = productCode
        self.productName        = productName
        self.productSignature   = productSignature
        self.salesValue         = salesValue
        self.lastPurchasePrice  = lastPurchasePrice
        self.accountProductId   = accountProductId
    }
}
