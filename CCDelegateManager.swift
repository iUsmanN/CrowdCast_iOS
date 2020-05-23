//
//  CCDelegateManager.swift
//  CrowdCast
//
//  Created by Usman on 21/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCChannelActionDelegate{
    func channelAdded(data: CCChannel)
    func channelRemoved(data: CCChannel)
}

protocol CCJoinChannelDelegate{
    func channelJoined(data: CCChannel)
}

protocol CCCrowdActionDelegate{
    func crowdAdded(data: CCCrowd)
    func crowdRemoved(data: CCCrowd)
}
