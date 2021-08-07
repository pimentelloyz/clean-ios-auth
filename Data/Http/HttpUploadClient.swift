import Foundation

public protocol HttpUploadClient {
    func upload(to url: URL, with data: Data?, and headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
