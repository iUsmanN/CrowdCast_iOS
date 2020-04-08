//
//  CCUser.swift
//  CrowdCast
//
//  Created by Usman on 06/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCUser           : Codable {
    var id              : String?
    var firstName       : String?
    var lastName        : String?
    var email           : String?
    
    //Local only
    var joinedChannels  : [String?]?
    var myChannels      : [String?]?
}
