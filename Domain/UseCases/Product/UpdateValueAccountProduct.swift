import Foundation

public protocol UpdateValueAccountProduct {
    typealias Result = Swift.Result<NoContentModel, DomainError>
    func update(by params: UpdateValueAccountProductParameters, to pathComponent: PathComponent, completion: @escaping (Result) -> Void)
}

public struct UpdateValueAccountProductParameters: Model {
    public let salesValue: Double
    
    public init(salesValue: Double) {
        self.salesValue     = salesValue
    }
}
