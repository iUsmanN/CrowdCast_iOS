//
//  CCConstantsManager.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
     struct Storyboards{
        static let Home         = UIStoryboard(name: "Home", bundle: nil)
        static let Onboarding   = UIStoryboard(name: "Onboarding", bundle: nil)
        static let Others       = UIStoryboard(name: "Others", bundle: nil)
        static let Channels     = UIStoryboard(name: "Channels", bundle: nil)
    }
    
    struct CardList{
        static let rowHeight    : CGFloat = 113
        static let headerHeight : CGFloat = 50
    }
}
