//
//  CCChannelsService.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol CCChannelsService : CCNetworkEngine, CCQueryEngine {}

extension CCChannelsService {
    
    func getMyChannels(completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        let query = make(.channelsData, in: "owners", contains: CCUserManager.sharedInstance.getUID())
        fetchData(query: query) { (result: Result<[CCChannel], Error>) in
            switch result {
            case .success(let channels) : completion(.success(paginatedData(data: channels, next: nil)))
            case .failure(let error)    : completion(.failure(error))
            }
        }
    }
    
    func getJoinedChannels(completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        let query = make(.channelsData, in: "members", contains: CCUserManager.sharedInstance.getUID())
        fetchData(query: query) { (result: Result<[CCChannel], Error>) in
            switch result {
            case .success(let channels) : completion(.success(paginatedData(data: channels, next: nil)))
            case .failure(let error)    : completion(.failure(error))
            }
        }
    }
}
