import Foundation

public struct ProductRegisteredByAccount: Model {
    public let body: [ProductRegisteredByAccountBody]
   
    public init(body: [ProductRegisteredByAccountBody]) {
        self.body = body
    }
}

public struct ProductRegisteredByAccountBody: Model {
    public let productId: Int
    public let productCode: String
    public let productName: String
    public let productSignature: Bool
    public let signatures: [SignatureValue]?
    
    public init(productId: Int,
                productCode: String,
                productName: String,
                productSignature: Bool,
                signatures: [SignatureValue]?) {
        self.productId          = productId
        self.productCode        = productCode
        self.productName        = productName
        self.productSignature   = productSignature
        self.signatures         = signatures
    }
}
