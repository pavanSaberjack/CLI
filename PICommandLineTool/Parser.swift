//
//  Parser.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/16/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

public struct Parser {
    public static func parse(at path: URL) {
        readFile(at: path)
        
//        guard let sampleData = "// this is comment".data(using: .utf8) else { return }
//
//        if let fileHandle = try? FileHandle(forWritingTo: path) {
//            fileHandle.seekToEndOfFile()
//            fileHandle.write(sampleData)
//            fileHandle.closeFile()
//        }
    }
    
    
}

private func readFile(at path: URL) {
    if let fileHandle = try? FileHandle(forReadingFrom: path) {
        
        let data = fileHandle.readDataToEndOfFile()
        print(String(data: data, encoding: .utf8) ?? "")        
//        fileHandle.readToEndOfFileInBackgroundAndNotify()
//
//        fileHandle.readabilityHandler = { (handler) in
//            prin
//        }
    }
}
