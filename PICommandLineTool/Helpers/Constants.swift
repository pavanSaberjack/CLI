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
    case removeCommentedCode = "removeCommentedCode"
}

extension Rule {
    func expression() -> [(String, String)] {
        switch self {
        case .multipleNewLine:
            return [("\\n +\\n", "\n\n"), ("\n{3,}", "\n\n")]
        case .print:
            return [(" *\\t*print\\(.*\\)\\n", "")]
        case .todo:
            return [("todo", "")]
        case .removeCommentedCode:
            return [("\\/\\/.*\n", "")]
        }
    }
}

enum FileExtension: String {
    case swift = "swift"
    case txt = "txt"
    case json = "json"
}
