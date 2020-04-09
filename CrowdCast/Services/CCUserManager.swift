//
//  CCUserManager.swift
//  CrowdCast
//
//  Created by Usman on 06/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

class CCUserManager {
    static let sharedInstance = CCUserManager()
    private var profile : CCUser?
    
    private init(){}
    
    func syncData(uid: String){
        fetchProfile(uid: uid)
    }
}

extension CCUserManager {
    
    func getProfile() -> CCUser? {
        return profile
    }
    
    func getJoinedChannelIDs() -> [String]{
        return profile?.joinedChannels?.compactMap({ $0 }) ?? [String]()
    }
}
extension CCUserManager : CCUserService {
    
    private func fetchProfile(uid: String){
        fetchUserProfile(uid: uid) { [weak self] (result) in
            switch result {
            case .failure(let error)        : prints("\(error)")
            case .success(let fetchedUser)  : self?.profile = fetchedUser
            }
        }
    }
    
    //private func syncChannels
    
    private func refreshChannels(){
        fetchMyChannelIDs(uid: profile?.id) { [weak self] result in
            switch result {
            case .failure(let error)        : prints(error)
            case .success(let fetchedIds)   : self?.profile?.myChannels = fetchedIds
            }
        }
    }
}
