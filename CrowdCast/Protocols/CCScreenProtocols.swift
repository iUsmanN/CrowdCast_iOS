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
    
    /// Opens Settings Screen
    func opensSettings(){
        navigationController?.pushViewController(instantiateViewController(storyboard: .Others,
                                                                           viewController: .CCSettingsVC,
                                                                           as: CCSettingsVC()),
                                                 animated: true)
    }
}

protocol CCAddChannel : CCSectionHeader, CCGetsViewController {}
extension CCAddChannel {
    
    /// Opens Add Channel Screen
    func addChannel(ownerID: String? = CCProfileManager.sharedInstance.getUID()){
        guard let nc = (window?.rootViewController as? CCTabBarController)?.selectedViewController as? UINavigationController else { return }
        let vc = instantiateViewController(storyboard: .Channels, viewController: .CCAddChannelVC, as: CCAddChannelVC())
        vc.viewModel.owner = ownerID ?? ""
        nc.pushViewController(vc, animated: true)
    }
}

protocol CCJoinChannel : CCSectionHeader {}
extension CCJoinChannel {
    
    /// Opens Join Channel Alert
    /// - Parameter bulletinManager: bulletin manager
    func joinChannel(_ bulletinManager: CCBulletinManager){
        bulletinManager.setItem(item: CCBulletinManager.joinChannel())
        guard let nc = ((window?.rootViewController as? CCTabBarController)?.selectedViewController as? UINavigationController)?.topViewController else { return }
        bulletinManager.manager?.showBulletin(above: nc)
    }
}

protocol CCAddGroup : CCCollectionSectionHeader, CCGetsViewController {}
extension CCAddGroup {
    
    /// Opens Add Group Screen
    func addGroup(){
        guard let nc = (window?.rootViewController as? CCTabBarController)?.selectedViewController as? UINavigationController else { return }
        nc.pushViewController(instantiateViewController(storyboard: .Groups,
                                                        viewController: .CCAddGroupVC,
                                                        as: CCAddCrowdVC()),
                                                        animated: true)
    }
}


protocol CCPinnedChannels : CCSectionHeader {}
extension CCPinnedChannels {
    
    /// Opens Pinned Channel Info
    /// - Parameter bulletinManager: bulletin manager
    func pinnedChannelInfo(_ bulletinManager: CCBulletinManager){
        bulletinManager.setItem(item: CCBulletinManager.pinnedChannelInfo())
        guard let nc = ((window?.rootViewController as? CCTabBarController)?.selectedViewController as? UINavigationController)?.topViewController else { return }
        bulletinManager.manager?.showBulletin(above: nc)
    }
}

protocol CCDynamicLinkPreview : UIViewController {}
extension CCDynamicLinkPreview {
    
    func previewDynamicLink(_ bulletinManager: CCBulletinManager?, channelName: String, deeplink: String){
        bulletinManager?.setItem(item: CCBulletinManager.shareDeepLink(channelName: channelName, deeplink: deeplink)
        )
        guard let nc = ((self.view.window?.rootViewController as? CCTabBarController)?.selectedViewController as? UINavigationController)?.topViewController else { return }
        bulletinManager?.manager?.showBulletin(above: nc)
    }
    
}
