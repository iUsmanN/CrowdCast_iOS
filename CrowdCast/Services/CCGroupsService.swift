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
}
