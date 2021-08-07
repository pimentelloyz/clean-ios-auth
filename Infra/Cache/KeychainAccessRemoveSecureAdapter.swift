import Foundation
import Data
import Domain
import KeychainAccess

public final class KeychainAccessRemoveSecureAdapter: RemoveSecureCacheStorage {
    private var keychain: Keychain
    
    public init(keychain: Keychain = .init(service: "authentication")) {
        self.keychain = keychain
    }
    
    public func remove(service: String, key: String) -> Bool {
        keychain = Keychain(service: service)
        if let _ = try? keychain.remove(key) {
            return true
        } else {
            return true
        }
    }
}
