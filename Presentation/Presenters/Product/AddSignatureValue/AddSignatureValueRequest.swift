import Foundation
import Domain

public struct AddSignatureValueRequest: Model {
    public let productId: Int?
    public var signatureItems: [SignatureItemsRequest]?
    
    public init(productId: Int? = nil,
                signatureItems: [SignatureItemsRequest]? = nil) {
        self.productId          = productId
        self.signatureItems     = signatureItems
    }
    
    public func toAddSignatureValueParameters() -> AddSignatureValueParameters {
        var itens = [SignatureItemsParameters]()
            self.signatureItems
                .map { $0.forEach { itens.append($0.toSignatureItemsParameters())} }
        return AddSignatureValueParameters(productId: self.productId!, signatureItems: itens)
    }
}

public struct SignatureItemsRequest: Model {
    public let monthCount: Int?
    public var salesValue: Double?
    
    public init(monthCount: Int? = nil,
                salesValue: Double? = nil) {
        self.monthCount     = monthCount
        self.salesValue     = salesValue
    }
    
    public func toSignatureItemsParameters() -> SignatureItemsParameters {
        return SignatureItemsParameters(monthCount: self.monthCount!, salesValue: self.salesValue!)
    }
}
