//
//  CCSectionHeaderData.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCSectionHeaderData {
    var title               : String
    var rightButtonTitle    : String?
    var rightButtonAction   : CardHeaderAction?
    var ownerID             : String? = CCProfileManager.sharedInstance.getUID()
}
