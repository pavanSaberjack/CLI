//
//  main.swift
//  PICommandLineTool
//
//  Created by Pavan on 11/15/19.
//  Copyright © 2019 Pavan Itagi. All rights reserved.
//

import Foundation

private var stderr = FileHandle.standardError

func start() {    
    let arguements = CommandLine.arguments
    
    guard arguements.count > 1 else {
        stderr.write("Expecting path argument!")
        exit(EXIT_FAILURE)
    }
    
    let folderPath = arguements[1]
    // TODO: handle validating of url path
//    guard folderPath.validFileURL else {
//        stderr.write("Not a valid path")
//        exit(EXIT_FAILURE)
//    }
    
    let cli = CLI()
    cli.run(at: folderPath)
}

start()
