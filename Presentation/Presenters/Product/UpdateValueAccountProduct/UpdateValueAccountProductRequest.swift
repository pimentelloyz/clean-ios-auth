import Foundation
import Domain

public struct UpdateValueAccountProductRequest: Model {
    public let salesValue: Double?
    
    public init(salesValue: Double? = nil) {
        self.salesValue  = salesValue
    }
    
    public func toUpdateValueAccountProductParameters() -> UpdateValueAccountProductParameters {
        return UpdateValueAccountProductParameters(salesValue: self.salesValue!)
    }
}
