import Foundation
import Domain

func makeLoadProductRegisteredByAccountParams() -> LoadProductRegisteredParameters {
    return LoadProductRegisteredParameters(offset: 10, limit: 0, search: "%")
}

func makeProductRegisteredByAccount() -> ProductRegisteredByAccount {
    return ProductRegisteredByAccount(productId: 0, productCode: "12345", productName: "O Grande Conflito", productSignature: false, signatures: nil)
}
