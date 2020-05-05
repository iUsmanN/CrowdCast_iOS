//
//  REUsersManager.swift
//  CrowdCast
//
//  Created by Usman on 05/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

//protocol REUsersManager {}

struct CCUsersManager : CCUserService {
    
    func newUsers(ids: [String]) -> ([CCUser],[String]) {
        
        var newUserIds      = [String]()
        var presentUsers    = [CCUser]()
        
        for id in ids {
            if id == reuse
            if let user = CCUserDefaults.shared.users?.value(forKey: id) as? CCUser {
                presentUsers.append(user)
            } else {
                newUserIds.append(id)
            }
        }
        return (presentUsers, newUserIds)
    }
    
    func getUserNames(ids: [String]) -> [String] {
       
    }
}
