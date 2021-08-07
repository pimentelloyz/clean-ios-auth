import Foundation

public protocol HttpGetClient {
    func get(to url: URL, with params: Data?, and headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
