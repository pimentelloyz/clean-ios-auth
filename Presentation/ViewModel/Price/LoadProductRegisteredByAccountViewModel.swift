import Foundation
import Domain

public protocol LoadProductRegisteredByAccountResultViewModel {
    func result(_ viewModel: LoadProductRegisteredByAccountViewModel)
}

public struct LoadProductRegisteredByAccountViewModel: Equatable {
    public let product: ProductRegisteredByAccount
    
    public init(product: ProductRegisteredByAccount) {
        self.product = product
    }
    
    public var numberOfSections: Int {
        return 1
    }
    
    public func numberOfItemsInSection(_ sections: Int) -> Int {
        return product.body.count
    }
    
    public func postByIndex(_ index: Int) -> LoadProductRegisteredByAccountBodyViewModel? {
        return LoadProductRegisteredByAccountBodyViewModel(product.body[index])
    }
    
    public func listPostBody() -> [LoadProductRegisteredByAccountBodyViewModel] {
        product.body.map({ LoadProductRegisteredByAccountBodyViewModel($0)})
    }
}

public struct LoadProductRegisteredByAccountBodyViewModel {
    public let body: ProductRegisteredByAccountBody?
    
    public init(_ body: ProductRegisteredByAccountBody?) {
        self.body = body
    }
}
