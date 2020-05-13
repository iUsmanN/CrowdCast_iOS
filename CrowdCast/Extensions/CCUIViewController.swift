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
import Kingfisher
import NotificationBannerSwift

class CCUIViewController: UIViewController {
    
    var combineCancellable  = Set<AnyCancellable>()
    static var reachibility : CCReachibility?
    var reachibilityBanner  : StatusBarNotificationBanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeTitles()
        addNotificationObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "Main Accent")
    }
    
    func setupLargeTitles(){
        navigationController?.view.backgroundColor = UIColor(named: "Background")
    }
    
    func addNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfilePicture), name: .profilePictureChanged, object: nil)
    }
    
    @objc func updateProfilePicture(){
        guard let profileIcon = navigationItem.rightBarButtonItem?.customView as? CCRoundButton else { return }
        if let url = URL(string: Constants.imageCacheString(id: CCProfileManager.sharedInstance.getUID())){
            profileIcon.kf.setImage(with: ImageResource(downloadURL: url,
                                    cacheKey: url.getQueryLessURL()?.absoluteString),
                                    for: .normal,
                                    placeholder: #imageLiteral(resourceName: "avatarMale"))
        }
    }
}
