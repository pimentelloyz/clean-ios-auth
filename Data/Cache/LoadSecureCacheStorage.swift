import Foundation

public protocol LoadSecureCacheStorage {
    func loadSecure(service: String, key: String) -> Data?
}
