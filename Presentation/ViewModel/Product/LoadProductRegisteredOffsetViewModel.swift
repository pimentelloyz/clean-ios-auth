import Foundation

public class LoadProductRegisteredOffsetViewModel {
    public var offset: Int
    public var search: String
    public let limit: Int
    
    public init(offset: Int = 0, limit: Int = 50, search: String = "%") {
        self.offset = offset
        self.limit  = limit
        self.search = search
    }
    
    public func incrementOffset() -> Void {
        self.offset = offset == 0 ? limit + 1 : limit
    }
    
    public func decrementOffset() -> Void {
        self.offset = offset == 0 ? offset : offset - (limit + 1)
    }
    
    public func resetDefaultOffset() -> Void {
        self.offset = 0
    }
    
    public func updateSearchQuery(newQuery: String) -> Void {
        self.search = newQuery != "" ? newQuery : "%"
    }
    
    public func resetDefaultvalues() {
        self.offset = 0
        self.self.search = "%"
    }
}
