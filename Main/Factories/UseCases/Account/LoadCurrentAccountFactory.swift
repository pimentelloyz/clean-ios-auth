import Data

func makeLoadSecureCurrentAccountFactory() -> LocalLoadSecureCurrentAccount {
    return LocalLoadSecureCurrentAccount(loadSecureCacheStorage: makeKeychainAccessLoadSecureAdapter())
}
