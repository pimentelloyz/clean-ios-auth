import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["name": "André"])
        XCTAssertEqual(errorMessage, "The field Email is required")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let sut = makeSut(fieldName: "age", fieldLabel: "Idade")
        let errorMessage = sut.validate(data: ["name": "André"])
        XCTAssertEqual(errorMessage, "The field Idade is required")
    }
    
    func test_validate_should_return_nil_if_field_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["email": "andre.loyz@gmail.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "The field Email is required")
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, fieldLabel: String) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut)
        return sut
    }
}
