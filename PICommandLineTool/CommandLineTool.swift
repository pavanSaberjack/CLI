
import Foundation

private var stderr = FileHandle.standardError

class CLI {
    
}

//pragma MARK: Private interface methods
extension CLI {
    
}

//pragma MARK: Public interface methods
extension CLI {
    public func run(at pathURL: URL) {
        stderr.write("Hello")
    }
    
    public func run(at path: String) {
        run(at: URL(fileURLWithPath: path))
    }
}
