import Foundation

public struct NoContentModel: Model {
    public var data: Data?
    
    public init(data: Data?) {
        self.data = data
    }
}
