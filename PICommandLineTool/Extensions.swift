
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



