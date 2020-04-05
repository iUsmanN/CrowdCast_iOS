//
//  CCCrowdModel.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCCrowd          : Codable {
    var Name            : String?
    var description     : String?
    var owners          : [CCIndividual?]?
    var members         : [CCIndividual?]?
    var channels        : [CCChannel]?
}
