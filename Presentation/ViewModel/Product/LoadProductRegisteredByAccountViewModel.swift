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
    
    public func numberOfRowsOnAddProductView() -> Int {
        return body?.productSignature ?? false ? 3 : 1
    }
    
    public var productId: Int {
        return self.body?.productId ?? 0
    }
    
    public var accountProductId: Int {
        return self.body?.accountProductId ?? 0
    }
    
    public var productName: String {
        return self.body?.productName ?? ""
    }
    
    public var isSignature: Bool {
        return self.body?.productSignature ?? false
    }
    
    public var productCode: String {
        return self.body?.productCode ?? "000"
    }
    
    public var codeAndNameProduct: String {
        return self.productCode + " - " + self.productName
    }
    
    public var signatures: [SignatureValue]? {
        return self.body?.signatures
    }
    
    public var salesValeu: String {
        return "\(self.body?.salesValue ?? 00.0)" 
    }
    
    public var lastPurchasePrice: String {
        return "\(self.body?.lastPurchasePrice ?? 00.0)"
    }
    
    public var signatureOptions: String {
        return "SIGNATURE_OPTIONS"
    }
}
