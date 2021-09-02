//
//  LoadProductNotRegisteredByAccountViewModel.swift
import Foundation
import Domain

public protocol LoadProductNotRegisteredByAccountResultViewModel {
    func result(_ viewModel: LoadProductNotRegisteredByAccountViewModel)
}

public struct LoadProductNotRegisteredByAccountViewModel: Equatable {
    public let product: ProductNotRegisteredByAccount
    
    public init(product: ProductNotRegisteredByAccount) {
        self.product = product
    }
    
    public var numberOfSections: Int {
        return 1
    }
    
    public func numberOfItemsInSection(_ sections: Int) -> Int {
        return product.body.count
    }
    
    public func productByIndex(_ index: Int) -> LoadProductNotRegisteredByAccountBodyViewModel? {
        return LoadProductNotRegisteredByAccountBodyViewModel(product.body[index])
    }
    
    public func listProductBody() -> [LoadProductNotRegisteredByAccountBodyViewModel] {
        product.body.map({ LoadProductNotRegisteredByAccountBodyViewModel($0)})
    }
}

public struct LoadProductNotRegisteredByAccountBodyViewModel {
    public let body: ProductNotRegisteredByAccountBody?
    
    public init(_ body: ProductNotRegisteredByAccountBody?) {
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