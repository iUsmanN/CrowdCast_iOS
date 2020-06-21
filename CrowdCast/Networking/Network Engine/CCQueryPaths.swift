//
//  CCQueryPaths.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

enum CCQueryPath : String {
    
    //Profile
    case userProfileData    = "/data/users"
    
    //Channels
    case channelsData       = "/data/channels"
    
    //Crowds
    case crowdData          = "/data/groups"
    
    //User-Crowds
    case userCrowds         = "/data/user-groups"
    
    //User Channels
    case userChannels       = "/data/user-channels"
    
    //Channels Uers
    case channelUsers       = "/data/channel-users"
    
    //Group-Channels
    case groupChannels      = "/data/group-channels"
}
