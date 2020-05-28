//
//  CCUserCrowd.swift
//  CrowdCast
//
//  Created by Usman on 24/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCUserCrowd  : Codable, CCContainsID {
    var id          : String?
    var owned       : [String]?
    var member      : [String]?
}

struct CCCrowdChannels  : Codable, CCContainsID {
    var id              : String?
    var owned           : [String]?
}
