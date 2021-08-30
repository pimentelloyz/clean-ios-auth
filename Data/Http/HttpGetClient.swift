import Foundation

public protocol HttpGetClient {
    func get(to url: URL, by params: Data?, headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
