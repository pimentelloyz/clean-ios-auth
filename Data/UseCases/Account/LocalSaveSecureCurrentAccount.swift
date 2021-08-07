import Foundation
import Domain

public final class LocalSaveSecureCurrentAccount: SaveSecureCurrentAccount {
    public var saveSecureCacheStorage: SaveSecureCasheStorage
    
    public init(saveSecureCacheStorage: SaveSecureCasheStorage) {
        self.saveSecureCacheStorage = saveSecureCacheStorage
    }
    
    public func save(account: AccountModel) {
        saveSecureCacheStorage.save(service: "authentication", value: account.body.accessToken)
    }
}
