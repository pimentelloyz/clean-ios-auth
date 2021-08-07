import Foundation
import Alamofire
import Data
import Domain

public final class AlamofireUploadImageAdapter: HttpUploadClient {
    private let session: SessionManager
    public typealias Result = Swift.Result
    public init(session: SessionManager = .default) {
        self.session = session
    }
    
    public func upload(to url: URL, with data: Data?, and headers: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        guard let image: UploadMultipart = data?.toModel() else {
            return completion(.failure(.noConnectivity))
        }
        
        session.upload(multipartFormData: { (MultipartFormData) in
            MultipartFormData.append(image.file, withName:"file", fileName: "file.jpg", mimeType: "image/jpg")
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers?.toHeaders()) { (result) in
            switch result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    completion(.success(response.data))
                }
                upload.responseJSON { response in
                    if let data = response.data {
                        completion(.success(data))
                    } else {
                        completion(.failure(.noConnectivity))
                    }
                }
            }
        }
    }
}
