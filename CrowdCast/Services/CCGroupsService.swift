//
//  CCGroupsService.swift
//  CrowdCast
//
//  Created by Usman on 23/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Firebase

protocol CCGroupsService : CCNetworkEngine, CCQueryEngine, CCDispatchQueue {}

extension CCGroupsService {
    
    
    /// Creates a Group
    /// - Parameters:
    ///   - groupInput: group data
    ///   - result: completion handler
    /// - Returns: nil
    func createGroup(groupInput: CCCrowd, result: @escaping (Result<CCCrowd, CCError>)->()){
        let query   = documentRef(.crowdData)
        var group   = groupInput
        group.id    = query.documentID
        do {
            try query.setData(from: group, encoder: .init(), completion: { (error) in
                guard error == nil else { result(.failure(.groupCreationFailure)); return }
                
                let dg = DispatchGroup()
                
                dg.enter()
                self.dispatchPriorityItem(.concurrent, code: {self.addUserGroupEntry(dg: dg, groupID: group.id, type: .owned, completion: result)})
                
                dg.notify(queue: .global(), execute: {result(.success(group))})
            })
        } catch {
            result(.failure(.groupCreationFailure))
        }
    }
    
    /// Get a Users Groups
    /// - Parameters:
    ///   - type: Type of groups. Can be *owned* or *member*
    ///   - completion: completion handler
    /// - Returns: nil
    func getGroups(type: CCCrowdRelation,completion: @escaping (Result<paginatedData<CCCrowd>, Error>) -> ()) {
        let query = userGroups()
        fetchData(query: query) { (result: Result<[CCUserCrowd], Error>) in
            switch result {
            case .success(let channels) :
                guard (type == CCCrowdRelation.owned ? (channels.first?.owned?.count ?? 0) : (channels.first?.member?.count ?? 0)) > 0 else { completion(.success(paginatedData(data: [CCCrowd](), next: nil))); return }
                let q = self.groupData(ids: type == CCCrowdRelation.owned ? channels.first?.owned : channels.first?.member)
                self.fetchData(query: q) { (result2: Result<[CCCrowd], Error>) in
                    switch result2 {
                    case .success(let crowds)   : completion(.success(paginatedData(data: crowds, next: nil)))
                    case .failure(let error)    : completion(.failure(error))
                    }
                }
            case .failure(let error)    : completion(.failure(error))
            }
        }
    }
}

extension CCGroupsService {
    
    func addEntries(dg: DispatchGroup, groupID: String?, completion: @escaping (Result<CCCrowd, CCError>)->()) {
        
    }
    
    func addGroupChannelsItem(dg: DispatchGroup, groupID: String?, completion: @escaping (Result<CCCrowd, CCError>)->()){
        
    }
    
    /// Adds created group to user-groups table
    /// - Parameters:
    ///   - dg: dispatch Group
    ///   - groupID: group ID
    ///   - type: Type of group. Can be *owned* or *member*
    ///   - completion: completion handler
    /// - Returns: nil
    func addUserGroupEntry(dg: DispatchGroup, groupID: String?, type: CCCrowdRelation, completion: @escaping (Result<CCCrowd, CCError>)->()) {
        guard let groupID = groupID else { dg.suspend(); completion(.failure(.addUserGroupEntryFailure)); return }
        userGroupsDocReferrence().updateData(["\(type.rawValue)": FieldValue.arrayUnion(["\(groupID)"])]) { (error) in
            guard error == nil else { dg.suspend(); completion(.failure(.addUserGroupEntryFailure)); return }
            dg.leave()
        }
    }
}