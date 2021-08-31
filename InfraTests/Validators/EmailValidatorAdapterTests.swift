import XCTest
import Infra

class EmailValidatorAdapterTests: XCTestCase {
    func test_should_return_false_if_invalid_email_is_provided() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "andre"))
        XCTAssertFalse(sut.isValid(email: "mail@"))
        XCTAssertFalse(sut.isValid(email: "mail@mail"))
        XCTAssertFalse(sut.isValid(email: "mail@mail."))
        XCTAssertFalse(sut.isValid(email: "@mail.com"))
    }
    
    func test_should_return_true_if_invalid_email_is_provided() throws {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "andre@mail.com"))
        XCTAssertTrue(sut.isValid(email: "andre@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "andre@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "andre.pimentel@iap.org.br"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
