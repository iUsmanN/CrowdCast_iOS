//
//  CCOpensSettingProtocol.swift
//  CrowdCast
//
//  Created by Usman on 02/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCOpensSettings : UIViewController {}
extension CCOpensSettings {
    
    func opensSettings(){
        navigationController?.pushViewController(Constants.Storyboards.Others.instantiateViewController(withIdentifier: "CCSettingsVC"), animated: true)
    }
}

protocol CCAddChannel : CCSectionHeader {}
extension CCAddChannel {
    
    func addChannel(){
        parentNavigationController?.pushViewController(Constants.Storyboards.Channels.instantiateViewController(withIdentifier: "CCAddChannelVC"), animated: true)
    }
}

protocol CCJoinChannel : CCSectionHeader {}
extension CCJoinChannel {
    
    func joinChannel(){
        parentNavigationController?.pushViewController(Constants.Storyboards.Channels.instantiateViewController(withIdentifier: "CCJoinChannelVC"), animated: true)
    }
}
