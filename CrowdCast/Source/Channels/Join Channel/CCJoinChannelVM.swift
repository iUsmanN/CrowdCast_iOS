//
//  CCJoinChannelVM.swift
//  CrowdCast
//
//  Created by Usman on 09/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCJoinChannelVM {
    private var data : CCChannel?
    
    var cameraOn    = true
    var micOn       = true
    
    init(channel: CCChannel?) {
        data = channel
    }
}

extension CCJoinChannelVM {
    
    func channelName() -> String {
        return data?.name ?? ""
    }
    
    func getData() -> CCChannel? {
        return data
    }
}
