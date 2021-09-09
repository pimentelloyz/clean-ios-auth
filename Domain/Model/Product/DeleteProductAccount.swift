import Foundation

public protocol DeleteProductAccount {
    typealias Result = Swift.Result<NoContentModel, DomainError>
    func delete(to pathComponent: PathComponent, completion: @escaping (Result) -> Void)
}
