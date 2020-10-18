//
//  CCUserManager.swift
//  CrowdCast
//
//  Created by Usman on 06/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

class CCProfileManager {
    static let sharedInstance = CCProfileManager()
    private var profile : CCUser?
    
    private init(){}
    
    func syncData(uid: String, result: @escaping (Result<Any?, CCError>) -> ()){
        fetchProfile(uid: uid) { [weak self] callbackResult in
            switch callbackResult {
            case .success(let fetchedUser):
                self?.profile = fetchedUser
                result(.success(nil))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}

extension CCProfileManager {
    
    func getProfile() -> CCUser? {
        return profile
    }
    
    func getUID() -> String {
        guard let uid = profile?.id else { return String() }
        return uid
    }
}
extension CCProfileManager : CCUserService {
    
    private func fetchProfile(uid: String, result: @escaping (Result<CCUser, CCError>) -> ()){
        fetchUserProfile(uid: uid) { [weak self] (callbackResult) in
            switch callbackResult {
            case .failure(let error)        : prints("\(error)")
            case .success(let fetchedUser)  : result(.success(fetchedUser))
            }
        }
    }
}
