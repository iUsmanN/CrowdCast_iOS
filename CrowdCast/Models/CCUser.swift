//
//  CCUser.swift
//  CrowdCast
//
//  Created by Usman on 06/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCUser           : Codable {
    var name            : String?
    var firstName       : String?
    var lastName        : String?
    var email           : String?
    var joinedGroups    : [String?]?
    var joinedChannels  : [String?]?
    var myGroups        : [String?]?
    var myChannels      : [String?]?
}
