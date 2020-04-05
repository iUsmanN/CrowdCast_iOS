//
//  CCOwner.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCChannelOwner <T:Codable> : Codable {
    var UID     : String?
    var details : T?
}
