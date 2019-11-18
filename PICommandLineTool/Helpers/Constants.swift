//
//  Constants.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/18/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

enum RegexExpression: String {
    case print = "print([^)])"
    case todo = "todo"
    case multipleNewLine = "\n\n+\n"
}
