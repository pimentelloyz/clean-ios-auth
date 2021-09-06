import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
