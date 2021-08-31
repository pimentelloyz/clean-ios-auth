import Foundation
import Validation

class EmailValidatorSpy: EmailValidator {
    var isValid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func mockEmailValidatorError() {
        self.isValid = false
    }
}
