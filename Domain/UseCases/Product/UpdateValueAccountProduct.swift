import Foundation

public protocol UpdateValueAccountProduct {
    typealias Result = Swift.Result<NoContentModel, DomainError>
    func update(by params: UpdateValueAccountProductParameters, to pathComponent: PathComponent, completion: @escaping (Result) -> Void)
}

public struct UpdateValueAccountProductParameters: Model {
    public let monthCount: Int
    public let salesValue: Double
    
    public init(monthCount: Int,
                salesValue: Double) {
        self.monthCount     = monthCount
        self.salesValue     = salesValue
    }
}
