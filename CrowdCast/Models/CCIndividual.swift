//
//  CCIndividualModel.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCIndividual : Codable {
    var ID          : String?
    var firstName   : String?
    var lastName    : String?
    var email       : String?
    var channels    : [String?]?
}
