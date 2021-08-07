import Foundation
import Domain

public protocol HttpDownloadFileClient {
    func download(to url: URL, with params: Data?, and headers: Data?, completion: @escaping (Result<HttpDownloadFileModel, HttpError>) -> Void)
}

public struct HttpDownloadFileModel {
    public let progress: Progress?
    public let filePath: String?
    public let completed: Bool
    
    public init(progress: Progress?, filePath: String?, completed: Bool) {
        self.progress = progress
        self.filePath = filePath
        self.completed = completed
    }
}
