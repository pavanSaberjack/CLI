//
//  FileHandle+extension.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/18/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

extension FileHandle: TextOutputStream {
    public func write(_ string: String) {
        write(Data((string + "\n").utf8))
    }
}
