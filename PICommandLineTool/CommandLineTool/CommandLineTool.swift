
import Foundation

private var stderr = FileHandle.standardError
private var allowedFileTypes: [FileExtension] = [.swift]
private var appliedRules: [Rule] = [.multipleNewLine]

class CLI {
    private var config: Config?
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
//                if content.lastPathComponent == "Parser.swift" {
//                    Parser.parse(at: content, config: config)
//                }
                guard let config = config else { return }
                guard let fileFormat = FileExtension(rawValue: content.pathExtension) else { return }
                if config.enabledFileFormats.contains(fileFormat) {
                    Parser.parse(at: content, config: config)
                    stderr.write(content.lastPathComponent)
                }
            }
        }
    }
}

//pragma MARK: Public interface methods
extension CLI {
    public func run(at pathURL: URL) {
        // Read other arguements
        config = Config.createConfig(at: pathURL)
        parse(at: pathURL)
    }
    
    public func run(at path: String) {
        run(at: URL(fileURLWithPath: path))
    }
}
