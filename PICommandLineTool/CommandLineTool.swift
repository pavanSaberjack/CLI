
import Foundation

private var stderr = FileHandle.standardError

class CLI {
    
}


//pragma MARK: Private interface methods
extension CLI {
    
    private func getContent(at pathURL: URL) -> [URL]? {
        let keys: [URLResourceKey] = [
            .isRegularFileKey, .isDirectoryKey,
            .isAliasFileKey, .isSymbolicLinkKey,
            .creationDateKey, .nameKey,
        ]
        
        let enumerationOptions: FileManager.DirectoryEnumerationOptions
        #if os(macOS)
            enumerationOptions = .skipsHiddenFiles
        #else
            enumerationOptions = []
        #endif
                
        do {
            return try FileManager.default.contentsOfDirectory(at: pathURL, includingPropertiesForKeys: keys, options: enumerationOptions)
        } catch let error {
            stderr.write(error.localizedDescription)
            return nil
        }
    }
    
    private func parse(at pathURL: URL) {
        let contents = getContent(at: pathURL)
        guard let contentURLs = contents else {
            return
        }
        
        for content in contentURLs {
            if FileManager.fileIsDir(fileURL: content) {
                // parse all the folders
                parse(at: content)
            } else {
                Parser.parse(at: content)
                stderr.write(content.lastPathComponent)
            }
        }
    }
}

//pragma MARK: Public interface methods
extension CLI {
    public func run(at pathURL: URL) {
        parse(at: pathURL)
    }
    
    public func run(at path: String) {
        run(at: URL(fileURLWithPath: path))
    }
}
