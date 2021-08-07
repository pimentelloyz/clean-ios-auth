import Foundation
import Domain

public final class LocalLoadSecureCurrentAccount: LoadSecureCurrentAccount {
    
    public var loadSecureCacheStorage: LoadSecureCacheStorage
    
    public init(loadSecureCacheStorage: LoadSecureCacheStorage) {
        self.loadSecureCacheStorage = loadSecureCacheStorage
    }
    
    public func load() -> AccountModel? {
        let data = loadSecureCacheStorage.loadSecure(service: "authentication", key: "token")
        if let accountModel: AccountModel = data?.toModel() {
            return accountModel
        } else {
            return nil
        }
    }
}
