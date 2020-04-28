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
        manager?.backgroundViewStyle = .blurred(style: .regular, isDark: false)
    }
    
    static func joinChannel() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Join Channel")
        page.actionButtonTitle      = "Scan QR Code"
        page.alternativeButtonTitle = "Enter Code"
        return page
    }
}
