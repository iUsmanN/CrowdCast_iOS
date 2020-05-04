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
                                owners: [CCProfileManager.sharedInstance.getUID()],
                                members: nil,
                                color: colors[selectedColor])
        createChannel(channelInput: channel, completion: completion)
    }
}
