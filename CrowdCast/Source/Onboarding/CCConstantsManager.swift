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
    
    enum StoryBoards    : String {
        case Home
        case Onboarding
        case Others
        case Channels
    }
    
    enum ViewControllers    : String {
        case ChannelDetails = "CCChannelDetailsVC"
        case CCSettingsVC
        case CCTabBar
        case CCOnboardingVC
        case CCAddChannelVC
        case CCJoinChannelVC
    }
//    
//    struct Storyboards {
//        static let Home         = UIStoryboard(name: "Home", bundle: nil)
//        static let Onboarding   = UIStoryboard(name: "Onboarding", bundle: nil)
//        static let Others       = UIStoryboard(name: "Others", bundle: nil)
//        static let Channels     = UIStoryboard(name: "Channels", bundle: nil)
//    }
    
    struct CardList {
        static let rowHeight    : CGFloat = 130
        static let headerHeight : CGFloat = 45
    }
}
