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

class CCUIViewController: UIViewController, CCImageStorage {
    
    var activeButton        : CCButton?
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
        navigationController?.navigationBar.tintColor = .label
    }
    
    func setupLargeTitles(){
        navigationController?.view.backgroundColor = UIColor(named: "Background")
    }
    
    func addNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfilePicture), name: .profilePictureChanged, object: nil)
    }
    
    @objc func updateProfilePicture(){
        print("DP Changed")
        guard let profileIcon = navigationItem.rightBarButtonItem?.customView as? CCRoundButton else { return }
        
        getImage2(memberID: CCProfileManager.sharedInstance.getUID()) { result in
            switch result {
            case .success(let url):
                KingfisherManager.shared.retrieveImage(with: url) { result in
                    switch result {
                    case .success(let imageResult):
                        profileIcon.setImage(imageResult.image, for: .normal)
                    case .failure(let _):
                        print("Cannot fetch profile image")
                    }
                }
            case .failure(let _):
                print("Cannot fetch profile image")
            }
        }
    }
}

extension CCUIViewController : CCPauseScreenProtocol {}
