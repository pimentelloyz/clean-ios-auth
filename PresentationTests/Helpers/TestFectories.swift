import Foundation
import Presentation

func makeGenerateTokenRequest(email: String? = "any-mail@gmail.com") -> GenerateTokenRequest {
    return GenerateTokenRequest(email: email)
}
