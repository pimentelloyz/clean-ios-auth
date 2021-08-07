import Foundation
import Data
import KeychainAccess

public final class KeychainAccessSaveSecureAdapter: SaveSecureCasheStorage {
    private var keychain: Keychain
    
    public init(keychain: Keychain = .init(service: "authentication")) {
        self.keychain = keychain
    }
    
    public func save(service: String, value: String) {
        keychain = Keychain(service: service)
        keychain["token"] = value
    }
}
