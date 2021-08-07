import Foundation

public protocol HttpDeleteClient {
    func delete(to url: URL, with params: Data?, and headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
