//
//  FileManager+extension.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/18/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

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
