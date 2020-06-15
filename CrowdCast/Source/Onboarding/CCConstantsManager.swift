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
    
    static let environment  : String = "develop"
    
    enum StoryBoards    : String {
        case Home
        case Onboarding
        case Others
        case Channels
        case Groups
        case Main
    }
    
    enum ViewControllers    : String {
        case CCChannelDetailsVC = "CCChannelDetailsVC"
        case CCSettingsVC
        case CCTabBar
        case CCOnboardingVC
        case CCAddChannelVC
        case CCJoinChannelVC
        case CCCallScreenVC
        case CCAddGroupVC
        case CCCrowdChannelsVC
        case CCLoginVC
        case CCEditChannelVC
    }
    
    static func imageCacheString(id: String?, directory: ImageCacheDirectory = .displays) -> String {
        return "https://firebasestorage.googleapis.com/v0/b/crowdcast-31303.appspot.com/o/\(directory.rawValue)%2F\(id ?? "ID_MISSING").png"
    }
    
    struct CardList {
        static let rowHeight    : CGFloat = 130
        static let headerHeight : CGFloat = 45
    }
    
    struct CrowdList {
        static let headerHeight : CGFloat = 100
    }
}
