import Data

func makeSaveSecureCurrentAccountFactory() -> LocalSaveSecureCurrentAccount {
    return LocalSaveSecureCurrentAccount(saveSecureCacheStorage: makeKeychainAccessSaveSecureAdapter())
}
