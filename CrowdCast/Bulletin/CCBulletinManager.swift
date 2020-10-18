//
//  CCBulletinManager.swift
//  CrowdCast
//
//  Created by Usman on 28/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import BLTNBoard

//protocol CCBulletinManager {}

class CCBulletinManager {
    
    var manager: BLTNItemManager?
    
    func setItem(item: BLTNItem) {
        manager = BLTNItemManager(rootItem: item)
        manager?.backgroundViewStyle = .dimmed
    }
    
    static func joinChannel() -> BLTNPageItem {
        let page = CCBLTNPageItem(title: "Join Channel")
        //page.actionButtonTitle      = "Scan QR Code"
        page.actionButtonTitle = "Join via Dynamic Link"
        page.actionHandler = { item in
            page.next = enterCode()
            item.manager?.displayNextItem()
        }
        return page
    }
    
    static func joinCrowd() -> BLTNPageItem {
        let page = CCBLTNPageItem(title: "Join Crowd")
        //page.actionButtonTitle      = "Scan QR Code"
        page.actionButtonTitle = "Join via Dynamic Link"
        page.actionHandler = { item in
            page.next = enterCode()
            item.manager?.displayNextItem()
        }
        return page
    }
    
    static func shareDeepLink(channelName: String, deeplink: String, viewController: UIViewController?) -> BLTNPageItem {
        let page = CCBLTNPageItem(title: "\(channelName) Dynamic Link")
        page.descriptionText    = deeplink
        page.actionButtonTitle  = "Share"
        page.actionHandler = { item in
            let vc = UIActivityViewController(activityItems: [deeplink], applicationActivities: [])
            item.manager?.dismissBulletin(animated: true)
            DispatchQueue.main.async { viewController?.present(vc, animated: true, completion: nil) }
        }
        return page
    }
    
    static func pinnedChannelInfo() -> BLTNPageItem {
        let page = CCBLTNPageItem(title: "Pinned Channels")
        page.actionButtonTitle      = "I Understand."
        page.descriptionText        = "You can locally pin Channels on your device for quick access."
        page.descriptionLabel?.font = UIFont(name: "Avenir", size: 14)
        page.actionHandler = { item in
            item.manager?.dismissBulletin(animated: true)
        }
        return page
    }
    
    static func enterCode() -> BLTNPageItem {
        let page =  CCBLTNPageItem(title: "Join via Dynamic Link")
        page.descriptionText = "Ask a Participant to share the dynamic Channel link to join."
        page.actionButtonTitle = "I Understand"
        page.actionHandler = { item in
            item.manager?.dismissBulletin(animated: true)
        }
        return page
    }
}

class CCBLTNPageItem : BLTNPageItem {
    
    override init(title: String) {
        super.init(title: title)
        appearance.actionButtonColor            = UIColor(named: "Main Accent") ?? UIColor.red
        appearance.alternativeButtonTitleColor  = UIColor(named: "Main Accent") ?? UIColor.red
        appearance.actionButtonTitleColor       = UIColor(named: "Background") ?? UIColor.red
        appearance.titleFontDescriptor          = UIFontDescriptor(name: "Avenir", size: 14)
        appearance.descriptionFontDescriptor    = UIFontDescriptor(name: "Avenir", size: 10)
        appearance.buttonFontDescriptor         = UIFontDescriptor(name: "Avenir", size: 13)
        appearance.titleFontSize                = 20
        appearance.actionButtonFontSize         = 16
        appearance.alternativeButtonFontSize    = 15
        appearance.descriptionFontSize          = 16
    }
}
