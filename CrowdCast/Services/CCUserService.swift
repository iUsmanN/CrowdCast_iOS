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
    
    func fetchUserProfile(uid: String, completion: @escaping (Result<CCUser, Error>) -> ()) {
        let query = make(.userProfileData, in: "id", equals: uid)
        fetchData(query: query) { (result: Result<[CCUser], Error>) in
            switch result {
            case .success(let users): completion(.success(users.first!))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func addNewUser(uid: String?, email: String?, firstName: String?, lastName: String?, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        do{
            let user = CCUser(id: uid, firstName: firstName, lastName: lastName, email: email)
            let _ = try collectionRef(.userProfileData).addDocument(from: user, encoder: .init()) { (error) in
                guard error == nil else {
                    completion(.failure(CCError.firebaseFailure)); return }
                
                let dg = DispatchGroup()
                
                dg.enter()
                self.dispatchPriorityItem(.concurrent, code: {self.createUserGroupItem(dg: dg, uuid: uid, completion: completion)})
                
                dg.notify(queue: .global(), execute: { completion(.success(true)) })
            }
        } catch {
            completion(.failure(CCError.firebaseFailure))
        }
    }
    
    func fetchMyChannelIDs(uid: String?, completion: @escaping (Result<[String]?, Error>) -> ()) {
        let query = make(.channelsData, in: "owners", contains: uid ?? "")
        fetchData(query: query) { (result: Result<[String], Error>) in
            switch result {
            case .success(let channels) : completion(.success(channels))
            case .failure(let error)    : completion(.failure(error))
            }
        }
    }
}

extension CCUserService {
    
    func createUserGroupItem(dg: DispatchGroup, uuid: String?, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let uuid = uuid else { completion(.failure(CCError.RequiredValuesEmpty)); dg.suspend(); return }
        collectionRef(.userCrowds).document("\(uuid)").setData(["id":"\(uuid)", "owned": [], "member": []], completion: { (error) in
            guard error == nil else { completion(.failure(CCError.firebaseFailure)); dg.suspend(); return}
            dg.leave()
        })
    }
}
