import Foundation

public struct SignatureValue: Model {
    let signatureValueId: Int
    let monthNumber: Int
    let saleValue: Double
    
    public init(signatureValueId: Int, monthNumber: Int, saleValue: Double) {
        self.signatureValueId = signatureValueId
        self.monthNumber = monthNumber
        self.saleValue = saleValue
    }
}
