//
//  CCNibManager.swift
//  CrowdCast
//
//  Created by Usman on 04/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

struct Nib {
    
    struct get {
        static let CCSectionHeader  = UINib(nibName: "CCSectionHeader", bundle: nil)
        static let CCCardTVC        = UINib(nibName: "CCCardTVCTableViewCell", bundle: nil)
    }
    
    struct reuseIdentifier {
        static let CCSectionHeader  = "CCSectionHeader"
        static let CCCardTVC        = "CCCardTVCTableViewCell"
        static let CCCallMemberCell = "CCCallMemberCell"
    }
}
