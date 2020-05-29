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
    func getChannels(type: CCChannelRelation, ids: [String]?, completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        //let query = make(.channelsData, in: "\(type.rawValue)", contains: CCProfileManager.sharedInstance.getUID())
        let query = channelData(ids: ids)
        fetchData(query: query) { (result: Result<[CCChannel], Error>) in
            switch result {
            case .success(let channels) : completion(.success(paginatedData(data: channels, next: nil)))
            case .failure(let error)    : completion(.failure(error))
            }
        }
    }
    
    func getUserChannels(type: CCChannelRelation,completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        let query = userChannels()
        fetchData(query: query) { (result: Result<[CCUserChannel], Error>) in
            switch result {
            case .success(let userChannels):
                prints(userChannels)
                guard type == .joined ? ((userChannels.first?.member?.count ?? 0) > 0) : ((userChannels.first?.owned?.count ?? 0) > 0) else { completion(.failure(CCError.getUserChannelsFailure)); return }
                self.getChannels(type: type, ids: type == .joined ? userChannels.first?.member : userChannels.first?.owned) { (result) in
                    switch result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        prints(error)
                    }
                }
            case .failure(let error):
                prints(error)
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
                self.addEntries(channelID: channel.id) { (result) in
                    switch result {
                    case .success(_)            : completion(.success(channel))
                    case .failure(let error)    : completion(.failure(error))
                    }
                }
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

extension CCChannelsService {
    
    /// Adds Entries in user-channels whenever required
    /// - Parameters:
    ///   - channelID: channel ID to be added
    ///   - completion: completion handler
    /// - Returns: nil
    func addEntries(channelID: String?, completion: @escaping (Result<Any?, CCError>)->()) {
        addUserChannelsEntry(channelID: channelID, type: .owned, completion: completion)
    }
    
    /// Adds created group to user-groups table
    /// - Parameters:
    ///   - dg: dispatch Group
    ///   - groupID: group ID
    ///   - type: Type of group. Can be *owned* or *member*
    ///   - completion: completion handler
    /// - Returns: nil
    func addUserChannelsEntry(channelID: String?, type: CCCrowdRelation, completion: @escaping (Result<Any?, CCError>)->()) {
        guard let channelID = channelID else { completion(.failure(.addUserChannelEntryFailure)); return }
        userChannelsDocReferrence().updateData(["\(type.rawValue)": FieldValue.arrayUnion(["\(channelID)"])]) { (error) in
            guard error == nil else { completion(.failure(.addUserChannelEntryFailure)); return }
            completion(.success(nil))
        }
    }
}
