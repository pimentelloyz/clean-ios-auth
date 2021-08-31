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
    
    
        func test_generate_should_call_generateToken_with_correct_values() throws {
            let generateTokenSpy = GenerateTokenSpy()
            let sut = makeSut(generateToken: generateTokenSpy)
    
            sut.generate(request: makeGenerateTokenRequest())
    
            XCTAssertEqual(generateTokenSpy.generateTokenParameters, makeGenerateTokenParameters())
        }
    
        func test_generate_should_show_default_error_message_if_generateToken_fails() throws {
            let generateTokenSpy = GenerateTokenSpy()
            let alertViewSpy = AlertViewSpy()
            let sut = makeSut(alertView: alertViewSpy, generateToken: generateTokenSpy)
            let exp = expectation(description: "waiting")
            alertViewSpy.observe { viewModel in
                XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Ocorreu um erro, tente novamente dentro de alguns instantes"))
                exp.fulfill()
            }
    
            sut.generate(request: makeGenerateTokenRequest())
            generateTokenSpy.completeWithError(.unexpected)
    
            wait(for: [exp], timeout: 1)
        }
    
        func test_generate_should_show_expired_session_error_message_if_generateToken_completes_with_unauthorized() throws {
            let generateTokenSpy = GenerateTokenSpy()
            let alertViewSpy = AlertViewSpy()
            let sut = makeSut(alertView: alertViewSpy, generateToken: generateTokenSpy)
            let exp = expectation(description: "waiting")
            alertViewSpy.observe { viewModel in
                XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Email e/ou senha inválido(s)"))
                exp.fulfill()
            }
    
            sut.generate(request: makeGenerateTokenRequest())
            generateTokenSpy.completeWithError(.expiredSession)
            wait(for: [exp], timeout: 1)
        }
    
        func test_generate_should_show_loading_when_calls_generateToken() throws {
            let loadingViewSpy = LoadingViewSpy()
            let generateTokenSpy = GenerateTokenSpy()
            let sut = makeSut(generateToken: generateTokenSpy, loadingView: loadingViewSpy)
            let exp = expectation(description: "waiting")
            loadingViewSpy.observe { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
                exp.fulfill()
            }
    
            sut.generate(request: makeGenerateTokenRequest())
    
            wait(for: [exp], timeout: 1)
            let exp2 = expectation(description: "waiting")
            loadingViewSpy.observe { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
                exp2.fulfill()
            }
            generateTokenSpy.completeWithError(.unexpected)
            wait(for: [exp2], timeout: 1)
        }
    
        func test_generate_should_call_saveCurrentAccount_with_correct_value() throws {
            let saveSecureCurrentAccountSpy = SaveSecureCurrentAccountSpy()
            let generateTokenSpy = GenerateTokenSpy()
            let accountModel = makeAccountModel()
            let sut = makeSut(generateToken: generateTokenSpy, saveSecureCurrentAccount: saveSecureCurrentAccountSpy)
            let exp = expectation(description: "waiting")
            saveSecureCurrentAccountSpy.observe { account in
                XCTAssertEqual(account, accountModel)
                exp.fulfill()
            }
    
            sut.generate(request: makeGenerateTokenRequest())
            generateTokenSpy.completeWithAccount(accountModel)
            wait(for: [exp], timeout: 1)
        }
    
        func test_generate_should_return_isLogged_true_if_generateToken_succeeds() throws {
            let generateTokenResultViewModelSpy = GenerateTokenResultViewModelSpy()
            let generateTokenSpy = GenerateTokenSpy()
            let sut = makeSut(generateToken: generateTokenSpy, generateTokenViewModel: generateTokenResultViewModelSpy)
            let exp = expectation(description: "waiting")
            generateTokenResultViewModelSpy.observe { account in
                XCTAssertEqual(account, GenerateTokenViewModel(account: account.account))
                exp.fulfill()
            }
    
            sut.generate(request: makeGenerateTokenRequest())
            generateTokenSpy.completeWithAccount(makeAccountModel())
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
