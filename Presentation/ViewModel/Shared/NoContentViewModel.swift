import Foundation
import Domain

public protocol ResultNoContentViewModel {
    func result(_ viewModel: NoContentViewModel)
}

public struct NoContentViewModel: Equatable {
    public var data: NoContentModel
    
    public init(data: NoContentModel) {
        self.data = data
    }
}
