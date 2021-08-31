import XCTest
import Presentation
import Validation

class ValidationCompositeTests: XCTestCase {
    func test_validate_should_return_error_if_validation_fails() throws {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationsSpy: [validationSpy])
        validationSpy.mockErro("Erro 1")
        let errorMessage = sut.validate(data: ["name": "André Pimentel"])
        XCTAssertEqual(errorMessage, "Erro 1")
    }
    
    func test_validate_should_return_correct_error_message() throws {
        let validationSpy = ValidationSpy()
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validationsSpy: [validationSpy, validationSpy2])
        validationSpy2.mockErro("Erro 2")
        let errorMessage = sut.validate(data: ["name": "André Pimentel"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_should_return_the_first_error_message() throws {
        let validationSpy = ValidationSpy()
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validationsSpy: [validationSpy, validationSpy2, validationSpy3])
        validationSpy2.mockErro("Erro 2")
        validationSpy3.mockErro("Erro 3")
        let errorMessage = sut.validate(data: ["name": "André Pimentel"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_should_return_nil_if_validation_succeeds() throws {
        let sut = makeSut(validationsSpy: [ValidationSpy(), ValidationSpy()])
        let errorMessage = sut.validate(data: ["name": "André Pimentel"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_call_validation_with_correct_data() throws {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationsSpy: [validationSpy])
        let data = ["name": "André Pimentel"]
        _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests {
    func makeSut(validationsSpy: [ValidationSpy], file: StaticString = #filePath, line: UInt = #line) -> ValidationComposite {
        let sut = ValidationComposite(validations: validationsSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
