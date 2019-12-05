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
    }
}

private func isMatchesExist(in fileContent: String, pattern: String) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let matches = regex.matches(in: fileContent)
        return matches.count > 0
    } catch let error {
        print(error)
    }
    return false
}

private func checkForMatches(at path: URL) {    
    do {
        let fileContents: String = try String(contentsOfFile: path.path, encoding: .utf8)
        let regex = try NSRegularExpression(pattern: "\n{2}+\n", options: NSRegularExpression.Options.caseInsensitive)
        let matches = regex.matches(in: fileContents)
        print(matches.count)
        print(fileContents)
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
            for expression in rule.expression() {
                let regex = expression.0
                let replacement = expression.1
                while (fileContents.containMatch(regex: regex)) {
                    fileContents = fileContents.replacingOccurrences(of: regex, with: replacement, options: [.regularExpression])
                }
            }
        }
        do {
            try fileContents.write(to: path, atomically: false, encoding: .utf8)
        } catch let error {
            print(error)
        }
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
