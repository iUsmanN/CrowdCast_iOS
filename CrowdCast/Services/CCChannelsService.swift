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
    
    
    /// Gets User Channels Information
    /// - Parameters:
    ///   - type: Type of channels to get
    ///   - completion: completion handler
    /// - Returns: nil
    func getUserChannels(type: CCChannelRelation, completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        let query = userChannels()
        fetchData(query: query) { (result: Result<[CCUserChannel], Error>) in
            switch result {
            case .success(let userChannels):
                guard type == .joined ? ((userChannels.first?.member?.count ?? 0) > 0) : ((userChannels.first?.owned?.count ?? 0) > 0) else { completion(.failure(CCError.getUserChannelsFailure)); return }
                self.getChannelData(type: type, ids: type == .joined ? userChannels.first?.member : userChannels.first?.owned) { (result) in
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
    
    /// Gets users channels Data
    /// - Parameters:
    ///   - type: channel type
    ///   - completion: completion handler
    /// - Returns: nil
    private func getChannelData(type: CCChannelRelation, ids: [String]?, completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        //let query = make(.channelsData, in: "\(type.rawValue)", contains: CCProfileManager.sharedInstance.getUID())
        let query = channelData(ids: ids)
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
    func createUserChannel(channelInput: CCChannel, completion: @escaping (Result<CCChannel, CCError>) -> ()) {
        let query   = documentRef(.channelsData)
        var channel = channelInput
        channel.id  = query.documentID
        do {
            try query.setData(from: channel, encoder: .init(), completion: { (error) in
                guard error == nil else { completion(.failure(CCError.channelDataWriteFailure)); return }
                self.addEntries(channelID: channel.id, type: .owned) { (result) in
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
    
    func joinUserChannel(channelID: String, completion: @escaping (Result<CCChannel, CCError>) -> ()) {
        do {
            self.addEntries(channelID: channelID, type: .member) { result in
                switch result {
                case .success(_) :
                    getChannelData(type: .joined, ids: [channelID]) { dataResult in
                        switch dataResult {
                        case .success(let paginatedData):
                            completion(.success(paginatedData.data.first ?? CCChannel()))
                        case .failure(let error):
                            completion(.failure(.firebaseFailure))
                        }
                    }
                case .failure(let error) :
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(CCError.channelDataWriteFailure))
        }
    }
    
    /// Edits created user channel
    /// - Parameters:
    ///   - channelInput: channel data
    ///   - completion: completion handler
    /// - Returns: nil
    func editUserChannel(channelInput: CCChannel, completion: @escaping (Result<CCChannel, CCError>) -> ()) {
        let query = userChannel(id: channelInput.id)
        do {
            try query.setData(from: channelInput, encoder: .init(), completion: { (error) in
                guard error == nil else { completion(.failure(.channelEditFailure)); return }
                completion(.success(channelInput))
            })
        } catch {
            completion(.failure(.channelEditFailure))
        }
    }
    
    /// Creates a new channel
    /// - Parameters:
    ///   - channelInput: channel data
    ///   - completion: completion handler
    /// - Returns: nil
    func createGroupChannel(channelInput: CCChannel,completion: @escaping (Result<CCChannel, CCError>) -> ()) {
        let query   = documentRef(.channelsData)
        var channel = channelInput
        channel.id  = query.documentID
        do {
            try query.setData(from: channel, encoder: .init(), completion: { (error) in
                guard error == nil else { completion(.failure(CCError.channelDataWriteFailure)); return }
                self.addGroupEntries(channel: channel) { (result) in
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
        
        //Remove Channel Object
        let query = collectionRef(.channelsData)
        query.document(channelInput.id ?? "").delete(completion: { (error) in
            guard error == nil else { completion(.failure(.channelDataWriteFailure)); return }
            completion(.success(channelInput))
        })
        //
        //        //Remove Channel from all Owners and Members
        //        let query2 = make(.userChannels, in: "member", contains: channelInput.id ?? "")
        //        query2.
    }
    
    func removeChannelFromAllUsers(channelInput: CCChannel, completion: @escaping (Result<CCChannel, CCError>) -> ()) {
        
    }
}

//User Channel
extension CCChannelsService {
    
    /// Adds Entries in user-channels whenever required
    /// - Parameters:
    ///   - channelID: channel ID to be added
    ///   - completion: completion handler
    /// - Returns: nil
    func addEntries(channelID: String?, type: CCCrowdRelation, completion: @escaping (Result<Any?, CCError>)->()) {
        let dg = DispatchGroup()
        dg.enter()
        addUserChannelsEntry(dg: dg, channelID: channelID, type: type, completion: completion)
        dg.notify(queue: .global()) { completion(.success(nil)) }
    }
    
    /// Adds created channel to user-channels table
    /// - Parameters:
    ///   - dg: dispatch Group
    ///   - groupID: group ID
    ///   - type: Type of group. Can be *owned* or *member*
    ///   - completion: completion handler
    /// - Returns: nil
    func addUserChannelsEntry(dg: DispatchGroup, channelID: String?, type: CCCrowdRelation, completion: @escaping (Result<Any?, CCError>)->()) {
        guard let channelID = channelID else { dg.suspend(); completion(.failure(.addUserChannelEntryFailure)); return }
        userChannelsDocReferrence().updateData(["\(type.rawValue)": FieldValue.arrayUnion(["\(channelID)"])]) { (error) in
            guard error == nil else { dg.suspend(); completion(.failure(.addUserChannelEntryFailure)); return }
            dg.leave()
        }
    }
    
    //Unused atm
    func addChannelUserEntry(dg: DispatchGroup, channelID: String?, type: CCCrowdRelation, completion: @escaping (Result<Any?, CCError>)->()) {
        guard let channelID = channelID else { dg.suspend(); completion(.failure(.addUserChannelEntryFailure)); return }
        channelUsersDocReferrence(id: channelID).updateData(["\(type.rawValue)": FieldValue.arrayUnion(["\(channelID)"])]) { (error) in
            guard error == nil else { dg.suspend(); completion(.failure(.addUserChannelEntryFailure)); return }
            dg.leave()
        }
    }
}

//Group Channel
extension CCChannelsService {
    
    /// Adds Entries in user-channels whenever required
    /// - Parameters:
    ///   - channelID: channel ID to be added
    ///   - completion: completion handler
    /// - Returns: nil
    func addGroupEntries(channel: CCChannel?, completion: @escaping (Result<Any?, CCError>)->()) {
        addGroupUserChannelsEntry(channel: channel, type: .owned, completion: completion)
    }
    
    /// Adds created group to user-groups table
    /// - Parameters:
    ///   - dg: dispatch Group
    ///   - groupID: group ID
    ///   - type: Type of group. Can be *owned* or *member*
    ///   - completion: completion handler
    /// - Returns: nil
    func addGroupUserChannelsEntry(channel: CCChannel?, type: CCCrowdRelation, completion: @escaping (Result<Any?, CCError>)->()) {
        guard let channel = channel else { completion(.failure(.addUserChannelEntryFailure)); return }
        groupChannelsDocReferrence(groupID: channel.owners?.first ?? "").updateData(["\(type.rawValue)": FieldValue.arrayUnion(["\(channel.id ?? "")"])]) { (error) in
            guard error == nil else { completion(.failure(.addUserChannelEntryFailure)); return }
            completion(.success(nil))
        }
    }
}
