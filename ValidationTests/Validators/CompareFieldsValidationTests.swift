import XCTest
import Presentation
import Validation

class CompareFieldsValidationTests: XCTestCase {
    func test_validate_should_return_error_if_comparation_fails() throws {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "12345"])
        XCTAssertEqual(errorMessage, "The field Confirmar Senha is invalid")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "12345"])
        XCTAssertEqual(errorMessage, "The field Confirmar Senha is invalid")
    }
    
    func test_validate_should_return_nil_if_comparation_succeeds() throws {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "123"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "The field Confirmar Senha is invalid")
    }
}

extension CompareFieldsValidationTests {
    func makeSut(fieldName: String, fieldNameToCompare: String, fieldLabel: String) -> Validation {
        let sut = CompareFieldsValidation(fieldName: fieldName, fieldNameToCompare: fieldNameToCompare, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut)
        return sut
    }
}
