//
//  CCCrowdModel.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCCrowd : Codable, CCOwnsChannels {
    var UID: String?
    var Name: String?
    var description: String?
    var owners: [CCIndividual]
    var ownedChannels: [CCChannel?]?
}
