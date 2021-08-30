import Foundation
import Domain

func makeLoadProductRegisteredByAccountParams() -> LoadProductRegisteredParameters {
    return LoadProductRegisteredParameters(offset: 10, limit: 0, search: "%")
}
