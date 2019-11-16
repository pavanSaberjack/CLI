
import Foundation

extension FileHandle: TextOutputStream {
    public func write(_ string: String) {
        write(Data(string.utf8))
    }
}

extension FileManager {
    //
    // Check if NSURL is a directory
    //
    class public func fileIsDir(fileURL: NSURL) -> Bool {
        var isDir: ObjCBool = false;
        FileManager.default.fileExists(atPath: fileURL.path!, isDirectory: &isDir)
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




