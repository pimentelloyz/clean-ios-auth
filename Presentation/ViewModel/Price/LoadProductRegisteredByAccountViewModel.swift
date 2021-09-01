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
    
    public func productByIndex(_ index: Int) -> LoadProductRegisteredByAccountBodyViewModel? {
        return LoadProductRegisteredByAccountBodyViewModel(product.body[index])
    }
    
    public func listProductBody() -> [LoadProductRegisteredByAccountBodyViewModel] {
        product.body.map({ LoadProductRegisteredByAccountBodyViewModel($0)})
    }
}

public struct LoadProductRegisteredByAccountBodyViewModel {
    public let body: ProductRegisteredByAccountBody?
    
    public init(_ body: ProductRegisteredByAccountBody?) {
        self.body = body
    }
    
    public var productName: String {
        return self.body?.productName ?? ""
    }
    
    public var salesValeu: String {
        return "\(self.body?.salesValue ?? 00.0)" 
    }
    
    public var lastPurchasePrice: String {
        return "\(self.body?.lastPurchasePrice ?? 00.0)"
    }
}
