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
    
    var channelRows         : [CCCellData] = [
        CCCellData(title: "Video", switchActions: nil),
        CCCellData(title: "Audio", switchActions: nil),
        CCCellData(title: "Participants"),
        CCCellData(title: "Accent Color")
    ]
    
    var adminRows           : [CCCellData] = [
        CCCellData(title: "Paritcipant Requests"),
        CCCellData(title: "Channel Managers"),
        CCCellData(title: "Delete", titleColor: #colorLiteral(red: 0.9227048251, green: 0.08703707769, blue: 0.1209332793, alpha: 1))
    ]
    
    var data                = CCChannel()
    var localVideoTrack     : LocalVideoTrack?
    
    init(channelData: CCChannel) {
        data = channelData
    }
}

extension CCChannelDetailsVM {
    
    func numberOfSections() -> Int {
        return 2
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
