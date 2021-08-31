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
}

extension GenerateTokenPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), generateToken: GenerateTokenSpy = GenerateTokenSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(), saveSecureCurrentAccount: SaveSecureCurrentAccountSpy = SaveSecureCurrentAccountSpy(), generateTokenViewModel: GenerateTokenResultViewModelSpy = GenerateTokenResultViewModelSpy(), file: StaticString = #filePath, line: UInt = #line) -> GenerateTokenPresenter {
        let sut = GenerateTokenPresenter(generateToken: generateToken, saveSecureCurrentAccount: saveSecureCurrentAccount, generateTokenViewModel: generateTokenViewModel, loadingView: loadingView, validation: validation, alertView: alertView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
