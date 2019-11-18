//
//  Parser.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/16/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

enum Expression: String {
    case print
    case todo
    case multipleNewLine
}


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

private func checkForMatches(at path: URL) {
    
    do {
        let fileContents: String = try String(contentsOfFile: path.path, encoding: .utf8)
        let updatedContents = fileContents.replacingOccurrences(of: "\n\n+\n", with: "\n\n", options: [.regularExpression])
        print(updatedContents)
        
        let regex = try NSRegularExpression(pattern: "\n\n+\n", options: NSRegularExpression.Options.caseInsensitive)
        let matches = regex.matches(in: fileContents, options: [], range: NSRange(location: 0, length: fileContents.utf16.count))

        print(matches)

        for match in matches {
            print(match.range)
            let range = match.range
            if let swiftRange = Range(range, in: fileContents) {
                print(fileContents[swiftRange])
            }
        }
    } catch let error {
        print(error)
    }
}

private func readFile(at path: URL) {
    do {
        let fileContents: String = try String(contentsOfFile: path.path, encoding: .utf8)
        let updatedContents = fileContents.replacingOccurrences(of: "\n\n+\n", with: "\n\n", options: [.regularExpression])
        print(updatedContents)
    } catch {
        print(error)
    }
}

private func matches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = text as NSString
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        return results.map { nsString.substring(with: $0.range)}
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}
