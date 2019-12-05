//
//  Config.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/18/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

enum ConfigFileName: String {
    case rules = ".formatter.yml"
}

enum ParseType: String {
    case none = ""
    case rules = "rules:"
    case fileFormats = "fileFormats:"
}

enum ParserStep: String {
    case none = ""
    case enable = "enable:"
    case disable = "disable:"
}

enum RuleParseState: Int {
    case none = 0
    case inProgress
    case end
}

public struct CurrentConfig {
    var type: ParseType = .none
    var step: ParserStep = .none
    var state: RuleParseState = .none
}

public struct Config {
    var enabledRules: [Rule] = []
    var disabledRules: [Rule] = []
    var enabledFileFormats: [FileExtension] = []
    var disabledFileFormats: [FileExtension] = []
    public static func createConfig(at pathURL: URL) -> Config? {
        var config: Config = Config()
        var parseState: CurrentConfig = CurrentConfig()
        let configFilePath: String = pathURL.deletingLastPathComponent().relativePath
        var url = URL(fileURLWithPath: configFilePath)
        url = url.appendingPathComponent(ConfigFileName.rules.rawValue)
        do {
            let contents = try String(contentsOf: url, encoding: .utf8)
            let lines = contents.components(separatedBy: .newlines)
            for line in lines {
                let string = line.trimmingCharacters(in: .whitespacesAndNewlines)
                if string.isEmpty {
                    continue
                }
                // Check for start of rules
                if string == ParseType.rules.rawValue {
                    parseState.type = .rules
                    parseState.step = .none
                    parseState.state = .inProgress
                    continue
                }
                if string == ParseType.fileFormats.rawValue {
                    parseState.type = .fileFormats
                    parseState.step = .none
                    parseState.state = .inProgress
                    continue
                }
                if string == ParserStep.enable.rawValue {
                    parseState.step = .enable
                    continue
                }
                if string == ParserStep.disable.rawValue {
                    parseState.step = .disable
                    continue
                }
                if parseState.state != .inProgress {
                    continue
                }
                if parseState.type == .rules {
                    if let rule = Rule(rawValue: string) {
                        if parseState.step == .enable {
                            config.enabledRules.append(rule)
                        } else if parseState.step == .disable {
                            config.disabledRules.append(rule)
                        }
                    }
                }
                if parseState.type == .fileFormats {
                    if let fileFormat = FileExtension(rawValue: string) {
                        if parseState.step == .enable {
                            config.enabledFileFormats.append(fileFormat)
                        } else if parseState.step == .disable {
                            config.disabledFileFormats.append(fileFormat)
                        }
                    }
                }
            }            
        } catch let error {
            print(error)
        }
        return config
    }
}
