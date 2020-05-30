//
//  CCCrowdChannelsVM.swift
//  CrowdCast
//
//  Created by Usman on 24/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Combine

class CCCrowdChannelsVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [CCSectionHeaderData(title: "Channels", rightButtonTitle: "Create New", rightButtonAction: .newChannel)]
    
    var crowdData : CCCrowd?
    
    let channelsPublisher   = PassthroughSubject<(dataAction, [IndexPath]), Never>()
    var channels            = paginatedData<CCChannel>()
    
    init(crowdDataInput: CCCrowd?) {
        crowdData = crowdDataInput
        sectionHeaderData[0].ownerID = crowdData?.id
        fetchFreshData()
    }
}

extension CCCrowdChannelsVM {
    
    func numberOfRows() -> Int {
        return channels.data.count
    }
    
    func dataForRow(indexPath: IndexPath) -> CCChannel {
        return channels.data[indexPath.row]
    }
}

extension CCCrowdChannelsVM : CCGroupsService, CCGetIndexPaths {
    
    func fetchFreshData(){
        getGroupChannels(groupID: crowdData?.id) { (result) in
            switch result {
            case .success(let fetchedChannels):
                self.channels.data = fetchedChannels
                self.channelsPublisher.send((.insert, self.getIndexPaths(array: fetchedChannels.addedRows())))
            case .failure(let error):
                prints(error)
            }
        }
    }
}

extension CCCrowdChannelsVM {
    
    func addCreatedChannel(channel: CCChannel){
//        myChannels.insertData(input: channel)
//        publishChannelUpdates(action: .insert, newCreatedChannels: 1, newJoinedChannels: 0)
    }
    
    func removeCreatedChannel(channel: CCChannel){
//        guard let removalIndex = myChannels.removeData(input: channel) else { return }
//        channelsPublisher.send((dataAction.remove, myRemovalIndexPath(index: removalIndex)))
//        prints("Removed Data")
    }
}
