//
//  CCChannelModel.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCChannel                : Codable, CCContainsID {
    var id                      : String?
    var name                    : String?
    var description             : String?
    var owners                  : [String]?
    var members                 : [String?]?
    var color                   : String?
    
    func debugDescription() -> String {
        return "\(name)\n\(description)\n\(owners)\n\(members)\n\(color)"
    }
}
