//
//  CCChannelsVM.swift
//  CrowdCast
//
//  Created by Usman on 04/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class CCChannelsVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [
        CCSectionHeaderData(title: "Your Channels"  , rightButtonTitle: "Create New"    , rightButtonAction: .newChannel),
        CCSectionHeaderData(title: "Joined Channels", rightButtonTitle: "Join Channel"  , rightButtonAction: .joinChannel)
    ]
    
    var dataListener        : ListenerRegistration?
    let channelsPublisher   = PassthroughSubject<(dataAction, [IndexPath]), Never>()
    var myChannels          = paginatedData<CCChannel>()
    var joinedChannels      = paginatedData<CCChannel>()
}

extension CCChannelsVM {
    
    func sectionHeader(section: Int) -> CCSectionHeaderData {
        return sectionHeaderData[section]
    }
    
    func numberOfSections() -> Int {
        return sectionHeaderData.count
    }
    
    func numberOfRows(section: Int) -> Int {
        switch section {
        case 0:
            return myChannels.data.count
        case 1:
            return joinedChannels.data.count
        default:
            return 0
        }
    }
    
    func dataForCellAt(indexPath: IndexPath) -> CCChannel {
        switch indexPath.section {
        case 0:
            return myChannels.data[indexPath.row]
        case 1:
            return joinedChannels.data[indexPath.row]
        default:
            return CCChannel()
        }
    }
}

extension CCChannelsVM : CCChannelsService, CCDispatchQueue, CCGetIndexPaths {
    
    func fetchFreshData() {
        
        let dg = DispatchGroup()
        
        var fetchedCounts = (0, 0)
        var newMyChannels      = 0
        var newJoinedChannels  = 0
        
        dg.enter()
        dispatchPriorityItem(.concurrent, code: {
            self.getUserChannels(type: .owned) { (result) in
                switch result {
                case .success(let inputData):
                    self.myChannels.updateData(input: inputData)
                    fetchedCounts = (inputData.data.count, fetchedCounts.1)
                    newMyChannels = inputData.data.count
                    dg.leave()
                case .failure(let error):
                    prints(error)
                    dg.leave()
                }
            }
        })
        
        dg.enter()
        dispatchPriorityItem(.concurrent, code: {
            self.getUserChannels(type: .joined) { (result) in
                switch result {
                case .success(let inputData):
                    self.joinedChannels.updateData(input: inputData)
                    fetchedCounts = (fetchedCounts.0, inputData.data.count)
                    newJoinedChannels = inputData.data.count
                    dg.leave()
                case .failure(let error):
                    prints(error)
                    dg.leave()
                }
            }
        })
        
        dg.notify(queue: .global()) { [weak self] in
            prints("Make index paths")
            self?.publishChannelUpdates(action: .insert, newCreatedChannels: newMyChannels, newJoinedChannels: newJoinedChannels)
        }
    }
    
    func publishChannelUpdates(action: dataAction, newCreatedChannels: Int, newJoinedChannels: Int){
        channelsPublisher.send((action, getDualIndexPaths(oldMyChannelCount: myChannels.data.count,
                                                                     newMyChannelCount: newCreatedChannels,
                                                                     oldJoinedChannelCount: joinedChannels.data.count,
                                                                     newJoinedChannelCount: newJoinedChannels,
                                                                     countTuple: (newCreatedChannels, newJoinedChannels)) ))
    }
    
    func reloadData() {
        myChannels.clearData()
        joinedChannels.clearData()
        fetchFreshData()
    }
}

extension CCChannelsVM {
    func addCreatedChannel(channel: CCChannel){
        myChannels.insertData(input: channel)
        publishChannelUpdates(action: .insert, newCreatedChannels: 1, newJoinedChannels: 0)
    }
    
    func removeCreatedChannel(channel: CCChannel){
        guard let removalIndex = myChannels.removeData(input: channel) else { return }
        channelsPublisher.send((dataAction.remove, myRemovalIndexPath(index: removalIndex)))
        prints("Removed Data")
    }
}

extension CCChannelsVM {
    
    func enableDataListener(){
        dataListener = userGroupsDocReferrence().addSnapshotListener { [weak self](snapshot, error) in
            self?.reloadData()
        }
    }
    
    func disableDataListener(){
        dataListener?.remove()
    }
}
