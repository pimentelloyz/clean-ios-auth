import Foundation

public protocol RemoveSecureCacheStorage {
    func remove(service: String, key: String) -> Bool
}
