//
//  CCEditChannelVM.swift
//  CrowdCast
//
//  Created by Usman on 07/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCEditChannelVM {
    var data : CCChannel?
}

extension CCEditChannelVM {
    
    func getChannelData() -> CCChannel? {
        return data
    }
}

extension CCEditChannelVM : CCChannelsService {
    
    mutating func saveChanges(name: String?, description: String?, foreignLink: String?, completion: @escaping (Result<CCChannel, CCError>)->()) {
        data?.name = name
        data?.description = description
        data?.foreignLink = foreignLink
        editUserChannel(channelInput: data ?? CCChannel(), completion: completion)
    }
}
