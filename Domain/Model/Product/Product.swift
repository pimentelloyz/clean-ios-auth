import Foundation

public struct Product: Model {
    let productId: Int
    let productCode: String
    let productName: String
    let productSignature: Bool
    let signatures: [SignatureValue]?
    
    public init(productId: Int, productCode: String, productName: String, productSignature: Bool, signatures: [SignatureValue]?) {
        self.productId = productId
        self.productCode = productCode
        self.productName = productName
        self.productSignature = productSignature
        self.signatures = signatures
    }
}
