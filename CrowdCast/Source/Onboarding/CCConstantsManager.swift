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
        case Home       = "Home"
        case Onboarding
        case Others
        case Channels
    }
    
    enum ViewControllers    : String {
        case ChannelDetails = "CCChannelDetailsVC"
    }
    
    struct Storyboards {
        static let Home         = UIStoryboard(name: "Home", bundle: nil)
        static let Onboarding   = UIStoryboard(name: "Onboarding", bundle: nil)
        static let Others       = UIStoryboard(name: "Others", bundle: nil)
        static let Channels     = UIStoryboard(name: "Channels", bundle: nil)
    }
    
    struct CardList {
        static let rowHeight    : CGFloat = 130
        static let headerHeight : CGFloat = 45
    }
    
//    struct Utils {
//        static func instantiateViewController<T:UIViewController>(storyboard: Constants.StoryBoards, viewController: Constants.ViewControllers, as: T) -> UIViewController {
//            guard let vc = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(identifier: viewController.rawValue) as? T else { return UIViewController() }
//            return vc
//        }
//    }
    
}
