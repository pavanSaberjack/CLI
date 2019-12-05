//
//  CommonHelper.swift
//  PICommandLineTool
//
//  Created by Pavan on 12/5/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

private var stderr = FileHandle.standardError

func getContent(at pathURL: URL) -> [URL]? {
    let keys: [URLResourceKey] = [
        .isRegularFileKey, .isDirectoryKey,
        .isAliasFileKey, .isSymbolicLinkKey,
        .creationDateKey, .nameKey,
    ]
    let enumerationOptions: FileManager.DirectoryEnumerationOptions
    #if os(macOS)
        enumerationOptions = .skipsHiddenFiles
    #else
        enumerationOptions = []
    #endif
    do {
        return try FileManager.default.contentsOfDirectory(at: pathURL, includingPropertiesForKeys: keys, options: enumerationOptions)
    } catch let error {
        stderr.write(error.localizedDescription)
        return nil
    }
}



