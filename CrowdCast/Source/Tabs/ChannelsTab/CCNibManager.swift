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
        static let CCSectionHeader          = UINib(nibName: "CCSectionHeader", bundle: nil)
        static let CCCardTVC                = UINib(nibName: "CCCardTVCTableViewCell", bundle: nil)
        static let CCSwitchTVC              = UINib(nibName: "CCSwitchTVC", bundle: nil)
        static let CCDetailsSegueTVC        = UINib(nibName: "CCDetailsSegueTVC", bundle: nil)
        static let CCTextCell               = UINib(nibName: "CCTextCell", bundle: nil)
        static let CCTableViewHeader        = UINib(nibName: "CCTableViewHeader", bundle: nil)
        static let CCCrowdCell              = UINib(nibName: "CCCrowdCell", bundle: nil)
        static let CCDetailsSectionHeader   = UINib(nibName: "CCDetailsSectionHeader", bundle: nil)
        static let CCEmptyTableView         = UINib(nibName: "CCEmptyTableView", bundle: nil)
        
    }
    
    struct reuseIdentifier {
        static let CCSectionHeader          = "CCSectionHeader"
        static let CCCardTVC                = "CCCardTVCTableViewCell"
        static let CCCallMemberCell         = "CCCallMemberCell"
        static let CCSwitchTVC              = "CCSwitchTVC"
        static let CCDetailsSegueTVC        = "CCDetailsSegueTVC"
        static let CCTextCell               = "CCTextCell"
        static let CCTableViewHeader        = "CCTableViewHeader"
        static let CCCardMemberCell         = "CCCardMemberCell"
        static let CCCrowdCell              = "CCCrowdCell"
        static let CCDetailsSectionHeader   = "CCDetailsSectionHeader"
        static let CCEmptyTableView         = "CCEmptyTableView"
    }
    
    static func nibFor(_ reuseIdentifier: String) -> UINib {
        return UINib(nibName: "\(reuseIdentifier)", bundle: nil)
    }
}
