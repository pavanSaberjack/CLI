
import Foundation

private var stderr = FileHandle.standardError
private var allowedFileTypes: [FileExtension] = [.swift]
private var appliedRules: [Rule] = [.multipleNewLine]

class CLI {
    private var config: Config?
}

//pragma MARK: Private interface methods
extension CLI {
    
    private func generateConfig(at pathURL: URL) {
        config = Config.createConfig(at: pathURL)
    }
    
    private func crawl(at pathURL: URL) {
        let contents = getContent(at: pathURL)
        guard let contentURLs = contents else {
            return
        }
        
        for url in contentURLs {
            parse(at: url)
        }
    }
    
    private func parse(at url: URL) {
        if FileManager.fileIsDir(fileURL: url) {
            // parse all the folders
            crawl(at: url)
        } else {
            guard let config = config else { return }
            guard let fileFormat = FileExtension(rawValue: url.pathExtension) else { return }
            guard config.enabledFileFormats.contains(fileFormat) else { return }
                            
            Parser.parse(at: url, config: config)
            stderr.write(url.lastPathComponent)
        }
    }
}

//pragma MARK: Public interface methods
extension CLI {
    public func run(at pathURL: URL) {
        // Read other arguements
        generateConfig(at: pathURL)
        crawl(at: pathURL)
    }
    
    public func run(at path: String) {
        run(at: URL(fileURLWithPath: path))
    }
}
