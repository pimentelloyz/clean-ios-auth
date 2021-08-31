import Domain

func makeGenerateTokenParameters() -> GenerateTokenParameters {
    return GenerateTokenParameters(email: "any-mail@gmail.com")
}

func makeAccountModel() -> AccountModel {
    return AccountModel(body: AccountModelBody(accessToken: "any-token"))
}
