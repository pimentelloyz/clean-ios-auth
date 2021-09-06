import Foundation
import Domain

public struct UpdateValueAccountProductRequest: Model {
    public let monthCount: Int?
    public let salesValue: Double?
    
    public init(monthCount: Int? = nil,
                salesValue: Double? = nil) {
        self.monthCount = monthCount
        self.salesValue  = salesValue
    }
    
    public func toUpdateValueAccountProductParameters() -> UpdateValueAccountProductParameters {
        return UpdateValueAccountProductParameters(monthCount: self.monthCount!, salesValue: self.salesValue!)
    }
}
