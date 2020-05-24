//
//  CCGroupsService.swift
//  CrowdCast
//
//  Created by Usman on 23/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCGroupsService : CCNetworkEngine, CCQueryEngine {}

extension CCGroupsService {
    
    func createGroup(groupInput: CCCrowd, result: @escaping (Result<CCCrowd, CCError>)->()){
        let query   = documentRef(.crowdData)
        var group   = groupInput
        group.id    = query.documentID
        do {
            try query.setData(from: group, encoder: .init(), completion: { (error) in
                guard error == nil else { result(.failure(.groupCreationFailure)); return }
                result(.success(group))
            })
        } catch {
            result(.failure(.groupCreationFailure))
        }
    }
    
    func getGroups(type: CCCrowdRelation,completion: @escaping (Result<paginatedData<CCCrowd>, Error>) -> ()) {
        let query = userGroups()
        fetchData(query: query) { (result: Result<[CCUserCrowd], Error>) in
            switch result {
            case .success(let channels) :
                let q = self.groups(ids: type == CCCrowdRelation.owned ? channels.first?.owned : channels.first?.member)
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
