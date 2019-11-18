
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
    
    func match(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        return (try? NSRegularExpression(pattern: regex, options: []))?.matches(in: self, options: [], range: NSMakeRange(0, count)).map { match in
            (0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
        } ?? []
    }
    
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
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
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
