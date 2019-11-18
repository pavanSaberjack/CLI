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

public struct Config {
    public static func createConfig(at pathURL: URL) {
        let configFilePath: String = pathURL.deletingLastPathComponent().relativePath
        var url = URL(fileURLWithPath: configFilePath)
        url = url.appendingPathComponent(ConfigFileName.rules.rawValue)
        do {
            let contents = try String(contentsOf: url, encoding: .utf8)
            print(contents)
        } catch let error {
            print(error)
        }
    }
}
