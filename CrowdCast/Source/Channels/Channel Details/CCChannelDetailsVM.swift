//
//  CCChannelDetailsVM.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import TwilioVideo

struct CCChannelDetailsVM {
    
    private var sectionTitles       : [String] = ["CHANNEL ACTIONS", "ADMIN ACTIONS"]
    
    var channelRows         : [CCCellData] = [
        CCCellData(title: "Participants"),
        CCCellData(title: "Accent Color"),
        CCCellData(title: "Leave", titleColor: #colorLiteral(red: 1, green: 0.01136767322, blue: 0, alpha: 1))
    ]
    
    var adminRows           : [CCCellData] = [
        CCCellData(title: "Paritcipant Requests"),
        CCCellData(title: "Channel Managers"),
        CCCellData(title: "Delete", titleColor: #colorLiteral(red: 1, green: 0, blue: 0.03409014148, alpha: 1))
    ]
    
    var data                = CCChannel()
    var localVideoTrack     : LocalVideoTrack?
    
    init(channelData: CCChannel?) {
        guard let channelData = channelData else { return }
        data = channelData
    }
}

extension CCChannelDetailsVM {
    
    func numberOfSections() -> Int {
        return (data.owners?.contains(CCProfileManager.sharedInstance.getUID()) ?? false) ? sectionTitles.count : sectionTitles.count - 1
    }
    
    func sectionTitle(section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func numberOfRows(section: Int) -> Int {
        switch section {
        case 0:
            return channelRows.count
        case 1:
            return adminRows.count
        default:
            return 0
        }
    }
    
    func dataForCell(indexPath: IndexPath) -> CCCellData {
        switch indexPath.section {
        case 0:
            return channelRows[indexPath.row]
        case 1:
            return adminRows[indexPath.row]
        default:
            return CCCellData(title: "NONE", switchActions: nil)
        }
    }
}

extension CCChannelDetailsVM : CCChannelsService {
    
    func deleteChannel(completion: ((Result<CCChannel, CCError>)->())?) {
        deleteChannel(channelInput: data) { (result) in
            completion?(result)
        }
    }
}
