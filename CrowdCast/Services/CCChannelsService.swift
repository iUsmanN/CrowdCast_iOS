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
    
    /// Gets users channels
    /// - Parameters:
    ///   - type: channel type
    ///   - completion: completion handler
    /// - Returns: nil
    func getChannels(type: CCChannelRelation,completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        let query = make(.channelsData, in: "\(type.rawValue)", contains: CCProfileManager.sharedInstance.getUID())
        fetchData(query: query) { (result: Result<[CCChannel], Error>) in
            switch result {
            case .success(let channels) : completion(.success(paginatedData(data: channels, next: nil)))
            case .failure(let error)    : completion(.failure(error))
            }
        }
    }
    
    /// Creates a new channel
    /// - Parameters:
    ///   - channelInput: channel data
    ///   - completion: completion handler
    /// - Returns: nil
    func createChannel(channelInput: CCChannel,completion: @escaping (Result<CCChannel, CCError>) -> ()) {
        let query   = documentRef(.channelsData)
        var channel = channelInput
        channel.id  = query.documentID
        do {
            try query.setData(from: channel, encoder: .init(), completion: { (error) in
                guard error == nil else { completion(.failure(CCError.channelDataWriteFailure)); return }
                completion(.success(channel))
            })
        } catch {
            completion(.failure(CCError.channelDataWriteFailure))
        }
    }
    
    /// Delete channel
    /// - Parameters:
    ///   - channelInput: channel data
    ///   - completion: completion handler
    /// - Returns: nil
    func deleteChannel(channelInput: CCChannel, completion: @escaping (Result<CCChannel, CCError>) -> ()) {
        let query = collectionRef(.channelsData)
        query.document(channelInput.id ?? "").delete(completion: { (error) in
            guard error == nil else { completion(.failure(.channelDataWriteFailure)); return }
            completion(.success(channelInput))
        })
    }
}
