//
//  CCUserService.swift
//  CrowdCast
//
//  Created by Usman on 06/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol CCUserService : CCNetworkEngine, CCQueryEngine, CCDispatchQueue {}

extension CCUserService {
    
    /// Fetches the user's profile
    /// - Parameters:
    ///   - uid: uuid of the user
    ///   - completion: completion handler
    /// - Returns: nli
    func fetchUserProfile(uid: String, completion: @escaping (Result<CCUser, Error>) -> ()) {
        let query = make(.userProfileData, in: "id", equals: uid)
        fetchData(query: query) { (result: Result<[CCUser], Error>) in
            switch result {
            case .success(let users): completion(.success(users.first!))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    /// Adds new user to database
    /// - Parameters:
    ///   - uid: user's id
    ///   - email: user's email
    ///   - firstName: user's first name
    ///   - lastName: user's last name
    ///   - completion: completion handler
    /// - Returns: nil
    func addNewUser(uid: String?, email: String?, firstName: String?, lastName: String?, completion: @escaping (Result<Bool, Error>) -> ()) {
        do{
            let user = CCUser(id: uid, firstName: firstName, lastName: lastName, email: email)
            _ = try collectionRef(.userProfileData).addDocument(from: user, encoder: .init()) { (error) in
                guard error == nil else { completion(.failure(CCError.firebaseFailure)); return }
                let dg = DispatchGroup();
                
                dg.enter()
                self.dispatchPriorityItem(.concurrent, code: {self.createUserGroupItem(dg: dg, uuid: uid, completion: completion)})
                
                dg.enter()
                self.dispatchPriorityItem(.concurrent, code: {self.createUserChannelItem(dg: dg, uuid: uid, completion: completion)})
                
                dg.notify(queue: .global(), execute: { completion(.success(true)) })
            }
        } catch {
            completion(.failure(CCError.firebaseFailure))
        }
    }
}

extension CCUserService {
    
    /// Adds user to the user-groups table
    /// - Parameters:
    ///   - dg: dispatch group
    ///   - uuid: uuid of the user
    ///   - completion: completion handler
    /// - Returns: nil
    func createUserGroupItem(dg: DispatchGroup, uuid: String?, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let uuid = uuid else { completion(.failure(CCError.RequiredValuesEmpty)); dg.suspend(); return }
        collectionRef(.userCrowds).document("\(uuid)").setData(["id":"\(uuid)", "owned": [], "member": []], completion: { (error) in
            guard error == nil else { completion(.failure(CCError.firebaseFailure)); dg.suspend(); return}
            dg.leave()
        })
    }
    
    /// Adds user to the user-channels table
    /// - Parameters:
    ///   - dg: dispatch group
    ///   - uuid: uuid of the user
    ///   - completion: completion handler
    /// - Returns: nil
    func createUserChannelItem(dg: DispatchGroup, uuid: String?, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let uuid = uuid else { completion(.failure(CCError.RequiredValuesEmpty)); dg.suspend(); return }
        collectionRef(.userChannels).document("\(uuid)").setData(["id":"\(uuid)", "owned": [], "member": []]) { (error) in
            guard error == nil else { completion(.failure(CCError.firebaseFailure)); dg.suspend(); return}
            dg.leave()
        }
    }
}
