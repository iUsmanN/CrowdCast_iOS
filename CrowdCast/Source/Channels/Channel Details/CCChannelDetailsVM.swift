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
        CCCellData(title: "Audio", switchActions: nil)
    
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
        default:
            return 0
        }
    }
    
    func dataForCell(indexPath: IndexPath) -> CCCellData {
        switch indexPath.section {
        case 0:
            return channelRows[indexPath.row]
        default:
            return CCCellData(title: "NONE", switchActions: nil)
        }
    }
}
