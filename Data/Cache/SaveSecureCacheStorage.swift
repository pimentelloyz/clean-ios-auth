import Foundation

public protocol SaveSecureCasheStorage {
    func save(service: String, value: String)
}
