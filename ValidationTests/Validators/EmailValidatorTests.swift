import XCTest
import Presentation
import Validation

class EmailValidatorTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: emailValidatorSpy)
        emailValidatorSpy.mockEmailValidatorError()
        let errorMessage = sut.validate(data: ["email": "invalid-email@mail.com"])
        XCTAssertEqual(errorMessage, "The field Email is invalid")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidatorSpy: emailValidatorSpy)
        emailValidatorSpy.mockEmailValidatorError()
        let errorMessage = sut.validate(data: ["email": "invalid-email@mail.com"])
        XCTAssertEqual(errorMessage, "The field Email2 is invalid")
    }

    func test_validate_should_return_nil_if_valid_email_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["email": "valid-email@mail.com"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "The field Email is invalid")
    }
}

extension EmailValidatorTests {
    func makeSut(fieldName: String, fieldLabel: String, emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(), file: StaticString = #filePath, line: UInt = #line) -> EmailValidation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidatorSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: emailValidatorSpy, file: file, line: line)
        return sut
    }
}
