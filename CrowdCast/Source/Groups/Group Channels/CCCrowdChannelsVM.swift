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
    
    var crowdData           : CCCrowd?
    var bulletin            = CCBulletinManager()
    let channelsPublisher   = PassthroughSubject<(dataAction, [IndexPath]?), Never>()
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
        getGroupChannels(groupID: crowdData?.id) { [weak self](result) in
            switch result {
            case .success(let fetchedChannels):
                self?.channels.clearData()
                self?.channels.data = fetchedChannels
                self?.channelsPublisher.send((CCCrowdChannelsVC.refresh ? .refresh : .insert, self?.getIndexPaths(array: fetchedChannels.addedRows())))
                CCCrowdChannelsVC.refresh = false
            case .failure(let error):
                prints(error)
            }
        }
    }
}

extension CCCrowdChannelsVM {
    
    func addCreatedChannel(channel: CCChannel){
        channels.insertData(input: channel)
        channelsPublisher.send((.insert, [IndexPath(row: 0, section: 0)]))
    }
    
    func removeCreatedChannel(channel: CCChannel){
//        guard let removalIndex = myChannels.removeData(input: channel) else { return }
//        channelsPublisher.send((dataAction.remove, myRemovalIndexPath(index: removalIndex)))
//        prints("Removed Data")
    }
}
