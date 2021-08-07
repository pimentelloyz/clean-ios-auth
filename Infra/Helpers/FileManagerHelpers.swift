import Foundation

func getSaveFileUrl(fileName: String) -> URL {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let nameUrl = URL(string: fileName)
    let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
    NSLog(fileURL.absoluteString)
    return fileURL
}

func fileAlreadySaved(fileName: String) -> Bool {
    do {
        let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
        for url in contents {
            if url.description.contains(fileName) {
                return true
            }
        }
    } catch {
        return false
    }
    return false
}
