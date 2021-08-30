import Foundation

public struct SignatureValue: Model {
    public let signatureValueId: Int
    public let monthNumber: Int
    public let saleValue: Double
    
    public init(signatureValueId: Int,
                monthNumber: Int,
                saleValue: Double) {
        self.signatureValueId   = signatureValueId
        self.monthNumber        = monthNumber
        self.saleValue          = saleValue
    }
}
