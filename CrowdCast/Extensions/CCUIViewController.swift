//
//  CCUIViewController.swift
//  CrowdCast
//
//  Created by Usman on 10/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Combine
import Reachability
import NotificationBannerSwift

class CCUIViewController: UIViewController {
    
    var combineCancellable  = Set<AnyCancellable>()
    static var reachibility : CCReachibility?
    var reachibilityBanner  : StatusBarNotificationBanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
