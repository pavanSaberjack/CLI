//
//  Parser.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/16/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

public struct Parser {
    public static func parse(at path: URL, config: Config?) {
        readFile(at: path, config: config)
        
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
        
        
        let regex = try NSRegularExpression(pattern: "\n\n+\n", options: NSRegularExpression.Options.caseInsensitive)
        let matches = regex.matches(in: fileContents)

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

private func readFile(at path: URL, config: Config?) {
    do {
        var fileContents: String = try String(contentsOfFile: path.path, encoding: .utf8)
        
        guard let config = config else { return }
        
        for rule in config.enabledRules {
            fileContents = fileContents.replacingOccurrences(of: rule.expression(), with: rule.replacement(), options: [.regularExpression])
        }
//        let updatedContents = fileContents.replacingOccurrences(of: "\n\n+\n", with: "\n\n", options: [.regularExpression])
        print(fileContents)
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

private func applyRule(rule: Rule) -> String {
    return ""
}
