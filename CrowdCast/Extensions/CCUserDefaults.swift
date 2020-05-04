//
//  CCUserDefaults.swift
//  CrowdCast
//
//  Created by Usman on 05/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCUserDefaults {
    static let shared = CCUserDefaults()
    var users : UserDefaults?
    
    private init(){
        users = UserDefaults.init(suiteName: "users")
    }
}
