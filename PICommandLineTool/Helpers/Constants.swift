//
//  Constants.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/18/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

public enum Rule: String {
    case print = "print"
    case todo = "todo"
    case multipleNewLine = "multipleNewLine"
}

extension Rule {
    func expression() -> [(String, String)] {
        switch self {
        case .multipleNewLine:
            return [("\\n +\\n", "\n"), ("\n\n+\n", "\n\n")]
        case .print:
            return [("print\\(.*\\)", "")]
        case .todo:
            return [("todo", "")]
        }
    }
}

enum FileExtension: String {
    case swift = "swift"
    case txt = "txt"
    case json = "json"
}
