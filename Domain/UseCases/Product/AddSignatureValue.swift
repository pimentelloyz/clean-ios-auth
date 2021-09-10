import Foundation

public protocol AddSignatureValue {
    typealias Result = Swift.Result<NoContentModel, DomainError>
    func add(with params: AddSignatureValueParameters, completion: @escaping (Result) -> Void)
}

public struct AddSignatureValueParameters: Model {
    public let productId: Int
    public let signatureItems: [SignatureItemsParameters]
    
    public init(productId: Int,
                signatureItems: [SignatureItemsParameters]) {
        self.productId          = productId
        self.signatureItems     = signatureItems
    }
}

public struct SignatureItemsParameters: Model {
    public let monthCount: Int
    public let salesValue: Double?
    
    public init(monthCount: Int,
                salesValue: Double?) {
        self.monthCount     = monthCount
        self.salesValue     = salesValue
    }
}
