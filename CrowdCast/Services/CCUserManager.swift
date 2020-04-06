//
//  CCUserManager.swift
//  CrowdCast
//
//  Created by Usman on 06/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCUserManager {
    static let sharedInstance = CCUserManager()
    
    private var profile : CCUser?
    
    private init(){
        //get userDetails
    }
}

extension CCUserManager : CCUserService {
    
    private func fetchProfile(){
        
    }
}
