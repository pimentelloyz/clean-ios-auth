import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, and headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
