import Foundation
import Alamofire
import Data

public final class AlamofireDownloadFileAdapter: HttpDownloadFileClient {
    private let session: SessionManager
    public typealias Result = Swift.Result
    public init(session: SessionManager = .default) {
        self.session = session
    }
    
    public func download(to url: URL, with params: Data?, and headers: Data?, completion: @escaping (Result<HttpDownloadFileModel, HttpError>) -> Void) {
        let fileUrl = getSaveFileUrl(fileName: "\(url)")
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        let urlPart = fileUrl.absoluteString.components(separatedBy: "/")
        if let fileName = urlPart.last {
            if fileAlreadySaved(fileName: fileName) {
                completion(.success(HttpDownloadFileModel(progress: nil, filePath: fileUrl.absoluteString, completed: true)))
                return
            }
            session.download(
                url,
                method: .get,
                parameters: params?.toJson(),
                encoding: JSONEncoding.default,
                headers: nil,
                to: destination).downloadProgress(closure: { (progress) in
                    completion(.success(HttpDownloadFileModel(progress: progress, filePath: nil, completed: false)))
            }).responseData { response in
                switch response.result {
                case.success(let data):
                    do {
                        try data.write(to: response.destinationURL!)
                    } catch {
                        completion(.failure(.noConnectivity))
                    }
                case .failure: completion(.failure(.badRequest))
                }
                if let destinationUrl = response.destinationURL {
                    completion(.success(HttpDownloadFileModel(progress: nil, filePath: destinationUrl.absoluteString, completed: true)))
                }
            }
        }
    }
}
