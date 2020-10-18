//
//  CCIndividualModel.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCIndividual     : Codable, CCContainsID {
    var id              : String? 
    var firstName       : String?
    var lastName        : String?
    var email           : String?
    
    func fullName() -> String {
        guard let firstName = firstName, let lastName = lastName else { return String() }
        return "\(firstName) \(lastName)"
    }
}
