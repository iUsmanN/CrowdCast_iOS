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
        page.actionButtonTitle      = "Scan QR Code"
        page.alternativeButtonTitle = "Enter Code"
        page.alternativeHandler = { item in
            page.next = enterCode()
            item.manager?.displayNextItem()
        }
        return page
    }
    
    static func enterCode() -> BLTNPageItem {
        let page =  CCBLTNPageItem(title: "Enter Channel Code")
        page.alternativeButtonTitle = "Enter Code"
        return page
    }
}

class CCBLTNPageItem : BLTNPageItem {
    
    override init(title: String) {
        super.init(title: title)
        appearance.actionButtonColor            = UIColor(named: "Main Accent") ?? UIColor.red
        appearance.alternativeButtonTitleColor  = UIColor(named: "Main Accent") ?? UIColor.red
        appearance.actionButtonTitleColor       = UIColor(named: "Background") ?? UIColor.red
        appearance.titleFontSize                = 20
        appearance.actionButtonFontSize         = 15
        appearance.alternativeButtonFontSize    = 13
    }
}
