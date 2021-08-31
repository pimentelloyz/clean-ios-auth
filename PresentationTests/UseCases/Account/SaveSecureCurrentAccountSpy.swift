import Domain

class SaveSecureCurrentAccountSpy: SaveSecureCurrentAccount {
    var emit: ((AccountModel) -> Void)?
    
    func observe(competion: @escaping (AccountModel) -> Void) {
        self.emit = competion
    }

    func save(account: AccountModel) {
        self.emit?(account)
    }
}
