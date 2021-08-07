import Foundation
import Data
import Domain
import KeychainAccess

public final class KeychainAccessLoadSecureAdapter: LoadSecureCacheStorage {
    private var keychain: Keychain
    
    public init(keychain: Keychain = .init(service: "authentication")) {
        self.keychain = keychain
    }
    
    public func loadSecure(service: String, key: String) -> Data? {
        keychain = Keychain(service: service)
        if let token = try? keychain.get(key) {
            let account = AccountModel(body: AccountModelBody(accessToken: token))
            return account.toData()
        } else {
            return nil
        }
    }
}
