//
//  CCPrint.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

var CCDebugEnabled = true

func prints(_ items: Any..., caller: String = #function) {
    let separator: String = " ", terminator: String = "\n"
    let output = items.map { "[CROWDCAST] \($0)"}.joined(separator: separator)
    if(CCDebugEnabled){
        Swift.print(output, terminator: terminator)
    }
}
