
import Foundation

extension FileHandle: TextOutputStream {
    public func write(_ string: String) {        
        write(Data((string + "\n").utf8))
    }
}

extension FileManager {
    //
    // Check if NSURL is a directory
    //
    class public func fileIsDir(fileURL: URL) -> Bool {
        var isDir: ObjCBool = false;
        FileManager.default.fileExists(atPath: fileURL.path, isDirectory: &isDir)
        return isDir.boolValue
    }
    
    //
    // Check if a path is a directory
    //
    class public func fileIsDir(path: String) -> Bool {
        var isDir: ObjCBool = false;
        FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
        return isDir.boolValue
    }
}

extension String {
    var verifyUrl: Bool {
        get {
            let url = URL(string: self)

            if url == nil || NSData(contentsOf: url!) == nil {
                return false
            } else {
                return true
            }
        }
    }
    
    var validFileURL: Bool {
        get {
            let url = URL(fileURLWithPath: self)
            return FileManager.default.fileExists(atPath: url.absoluteString)
        }
    }
    
    
}

extension URL {
    var verifyUrl: Bool {
        get {
            if NSData(contentsOf: self) == nil {
                return false
            } else {
                return true
            }
        }
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    convenience init(_ pattern: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) {
        do {
            try self.init(pattern: pattern, options: options)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
    
    func matches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [NSTextCheckingResult] {
        return matches(in: string, options: options, range: NSRange(location: 0, length: string.utf16.count))
    }
}
