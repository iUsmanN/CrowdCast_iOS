//
//  CCAddChannelVM.swift
//  CrowdCast
//
//  Created by Usman on 19/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCAddChannelVM {
    
}

extension CCAddChannelVM {
    
    func channelOwner() -> String {
        return "\(CCUserManager.sharedInstance.getProfile()?.fullName() ?? String()) (You)"
    }
}

extension CCAddChannelVM : CCChannelsService {
    func addChannel(nameInput: String?, descriptionInput: String?, completion: @escaping ((Result<CCChannel, Error>)->())){
        let channel = CCChannel(id: nil,
                                name: nameInput,
                                description: descriptionInput,
                                owners: [CCUserManager.sharedInstance.getUID()],
                                members: nil,
                                color: "red")
        createChannel(channelInput: channel, completion: completion)
    }
}
