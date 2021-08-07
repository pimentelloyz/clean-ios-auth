import Foundation
import Domain

public struct PathComponentRequest: Model {
    public var path: String?
    
    public init (path: String? = "") {
        self.path = path
    }
    
    public func toPathComponent() -> PathComponent {
        return PathComponent(path: self.path!)
    }
}
