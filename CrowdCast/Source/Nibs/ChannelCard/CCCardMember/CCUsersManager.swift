//
//  CCUsersManager.swift
//  CrowdCast
//
//  Created by Usman on 05/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

//protocol REUsersManager {}

struct CCUsersManager : CCUserService {
    static let sharedInstance = CCUsersManager()
    private init() {}
}

extension CCUsersManager : CCDispatchQueue {
    
    private func checkUserData(ids: [String]?) -> ([CCUser?],[String?]) {
        var newUserIds      = [String?]()
        var presentUsers    = [CCUser?]()
        guard let ids = ids else { return (presentUsers, newUserIds) }
        for id in ids {
            if id == CCProfileManager.sharedInstance.getUID() {
                presentUsers.append(CCProfileManager.sharedInstance.getProfile())
            } else if let user = CCUserDefaults.shared.users?.value(forKey: id) as? CCUser {
                presentUsers.append(user)
            } else {
                newUserIds.append(id)
            }
        }
        return (presentUsers, newUserIds)
    }
    
    func getUserNames(ids: [String]?, completion: @escaping ([String?])->()) {
        var (presentUsers, newUserIds) = checkUserData(ids: ids)
        let dispatchGroup = DispatchGroup()
        
        for id in newUserIds {
            dispatchGroup.enter()
            dispatchPriorityItem(.concurrent) {
                self.fetchUserProfile(uid: id ?? "") { (result) in
                    switch result {
                    case .success(let user):
                        CCUserDefaults.shared.users?.set(user, forKey: id ?? "")
                        presentUsers.append(user)
                        dispatchGroup.leave()
                    case .failure(_):
                        dispatchGroup.leave()
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .global(), work: DispatchWorkItem(qos: .userInteractive, flags: .init(), block: {
            completion(presentUsers.map { (user) -> String? in
                return user?.fullName()
            })
        }))
    }
}
