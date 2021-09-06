import Foundation

public protocol HttpPutClient {
    func put(to url: URL, with data: Data?, headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
