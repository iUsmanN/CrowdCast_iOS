//
//  CCAddChannelVM.swift
//  CrowdCast
//
//  Created by Usman on 19/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

struct CCAddChannelVM {
    var selectedColor = 0
    var owner = CCProfileManager.sharedInstance.getUID()
    let colors : [String] = [
        "Main Accent",
        "red",
        "green",
        "yellow"
    ]
}

extension CCAddChannelVM {
    
    func channelOwner() -> String {
        return "\(CCProfileManager.sharedInstance.getProfile()?.fullName() ?? String()) (You)"
    }
    
    func numberOfColors() -> Int {
        return colors.count
    }
    
    func colorForItemAt(indexPath: IndexPath) -> UIColor? {
        return UIColor(named: colors[indexPath.row])
    }
}

extension CCAddChannelVM : CCChannelsService {
    func addChannel(nameInput: String?, descriptionInput: String?, completion: @escaping ((Result<CCChannel, CCError>)->())){
        guard nameInput != nil else { completion(.failure(.RequiredValuesEmpty)); return }
        let channel = CCChannel(id: nil,
                                name: nameInput,
                                description: descriptionInput,
                                owners: [owner],
                                members: nil,
                                color: colors[selectedColor],
                                isGroupChannel: owner == CCProfileManager.sharedInstance.getUID() ? false : true)
        owner == CCProfileManager.sharedInstance.getUID() ? createUserChannel(channelInput: channel, completion: completion) : createGroupChannel(channelInput: channel, completion: completion)
    }
}
