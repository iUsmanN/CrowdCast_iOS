//
//  CCOpensSettingProtocol.swift
//  CrowdCast
//
//  Created by Usman on 02/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCOpensSettings : UIViewController, CCGetsViewController {}
extension CCOpensSettings {
    
    func opensSettings(){
        navigationController?.pushViewController(instantiateViewController(storyboard: .Others,
                                                                           viewController: .CCSettingsVC,
                                                                           as: CCSettingsVC()),
                                                                           animated: true)
    }
}

protocol CCAddChannel : CCSectionHeader, CCGetsViewController {}
extension CCAddChannel {
    
    func addChannel(){
        parentNavigationController?.pushViewController(instantiateViewController(storyboard: .Channels,
                                                                                 viewController: .CCAddChannelVC,
                                                                                 as: CCAddChannelVC()),
                                                                                 animated: true)
    }
}

protocol CCJoinChannel : CCSectionHeader {}
extension CCJoinChannel {
    
    func joinChannel(){
        parentNavigationController?.pushViewController(instantiateViewController(storyboard: .Channels,
                                                                                 viewController: .CCJoinChannelVC,
                                                                                 as: CCJoinChannelVC()),
                                                                                 animated: true)
    }
}
