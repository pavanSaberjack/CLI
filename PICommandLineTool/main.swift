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
    stderr.write(arguements.first ?? "")
            
    let cli = CLI()
//    cli.run(at: <#T##URL#>)
}

start()


