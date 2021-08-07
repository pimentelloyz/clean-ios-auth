import Foundation

public struct UploadMultipart: Model {
    public let file: Data
    
    public init(file: Data) {
        self.file = file
    }
}
