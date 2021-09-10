import Foundation

public protocol UpdateSignatureValue {
    typealias Result = Swift.Result<NoContentModel, DomainError>
    func update(with params: UpdateSignatureValueParemeters, to pathComponent: PathComponent, completion: @escaping (Result) -> Void)
}

public struct UpdateSignatureValueParemeters: Model {
    public let accountProductId: Int
    public let signatureItems: [UpdateSignatureItemsParameters]
    
    public init(accountProductId: Int,
                signatureItems: [UpdateSignatureItemsParameters]) {
        self.accountProductId   = accountProductId
        self.signatureItems     = signatureItems
    }
}

public struct UpdateSignatureItemsParameters: Model {
    public let signatureValueId: Int
    public let monthCount: Int
    public let salesValue: Double?
    
    public init(signatureValueId: Int,
                monthCount: Int,
                salesValue: Double?) {
        self.signatureValueId   = signatureValueId
        self.monthCount         = monthCount
        self.salesValue         = salesValue
    }
}
