//
//  CCIndividualModel.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCIndividual     : Codable {
    var name            : String?
    var firstName       : String?
    var lastName        : String?
    var email           : String?
    var groups          : [CCCrowd?]?
    var channels        : [CCChannel?]?
}
