import Foundation
import Firebase

func firebaseToValidData(user: User) -> Data {
    return Data("{\"name\":\"\(user.displayName ?? "")\", \"email\":\"\(user.email ?? "")\"}".utf8)
}
