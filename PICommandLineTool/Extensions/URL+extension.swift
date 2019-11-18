//
//  URL+extension.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/18/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

extension URL {
    var verifyUrl: Bool {
        get {
            if NSData(contentsOf: self) == nil {
                return false
            } else {
                return true
            }
        }
    }
}
