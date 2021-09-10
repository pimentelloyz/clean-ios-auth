import Foundation

public struct SignatureValue: Model {
    public let signatureValueId: Int
    public let monthNumber: Int
    public let salesValue: Double?
    
    public init(signatureValueId: Int,
                monthNumber: Int,
                salesValue: Double?) {
        self.signatureValueId   = signatureValueId
        self.monthNumber        = monthNumber
        self.salesValue         = salesValue
    }
}
