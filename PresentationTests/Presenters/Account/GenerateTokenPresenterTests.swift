import XCTest
import Presentation
import Domain

class GenerateTokenPresenterTests: XCTestCase {
    func test_generate_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let request = makeGenerateTokenRequest()
        
        sut.generate(request: request)
        
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: request.toJson()!))
    }
    
    func test_generate_should_show_error_message_if_validation_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()

        sut.generate(request: makeGenerateTokenRequest(email: nil))

        wait(for: [exp], timeout: 1)
    }
}

extension GenerateTokenPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), generateToken: GenerateTokenSpy = GenerateTokenSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(), saveSecureCurrentAccount: SaveSecureCurrentAccountSpy = SaveSecureCurrentAccountSpy(), generateTokenViewModel: GenerateTokenResultViewModelSpy = GenerateTokenResultViewModelSpy(), file: StaticString = #filePath, line: UInt = #line) -> GenerateTokenPresenter {
        let sut = GenerateTokenPresenter(generateToken: generateToken, saveSecureCurrentAccount: saveSecureCurrentAccount, generateTokenViewModel: generateTokenViewModel, loadingView: loadingView, validation: validation, alertView: alertView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
