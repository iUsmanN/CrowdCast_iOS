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
        case Groups
    }
    
    enum ViewControllers    : String {
        case ChannelDetails = "CCChannelDetailsVC"
        case CCSettingsVC
        case CCTabBar
        case CCOnboardingVC
        case CCAddChannelVC
        case CCJoinChannelVC
        case CCCallScreenVC
        case CCAddGroupVC
        case CCCrowdChannelsVC
    }
    
    static func imageCacheString(id: String?, directory: imageCacheDirectory = .displays) -> String {
        return "https://firebasestorage.googleapis.com/v0/b/crowdcast-31303.appspot.com/o/\(directory.rawValue)%2F\(id ?? "ID_MISSING").png"
    }
    
    struct CardList {
        static let rowHeight    : CGFloat = 130
        static let headerHeight : CGFloat = 45
    }
}
