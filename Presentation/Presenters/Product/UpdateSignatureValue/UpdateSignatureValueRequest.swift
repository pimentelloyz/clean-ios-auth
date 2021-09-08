import Foundation
import Domain

public struct UpdateSignatureValueRequest: Model {
    public let accountProductId: Int?
    public var signatureItems: [UpdateSignatureItemsRequest]?
    
    public init(accountProductId: Int? = nil,
                signatureItems: [UpdateSignatureItemsRequest]? = nil) {
        self.accountProductId   = accountProductId
        self.signatureItems     = signatureItems
    }
    
    public func toUpdateSignatureValueParemeters() -> UpdateSignatureValueParemeters {
        var itens = [UpdateSignatureItemsParameters]()
            self.signatureItems
                .map { $0.forEach { itens.append($0.toUpdateSignatureItemsParameters())} }
        return UpdateSignatureValueParemeters(accountProductId: self.accountProductId!, signatureItems: itens)
    }
}

public struct UpdateSignatureItemsRequest: Model {
    public let signatureValueId: Int?
    public let monthCount: Int?
    public var salesValue: Double?
    
    public init(signatureValueId: Int? = nil,
                monthCount: Int? = nil,
                salesValue: Double? = nil) {
        self.signatureValueId   = signatureValueId
        self.monthCount         = monthCount
        self.salesValue         = salesValue
    }
    
    public func toUpdateSignatureItemsParameters() -> UpdateSignatureItemsParameters {
        return UpdateSignatureItemsParameters(signatureValueId: self.signatureValueId!, monthCount: self.monthCount!, salesValue: self.salesValue!)
    }
}
