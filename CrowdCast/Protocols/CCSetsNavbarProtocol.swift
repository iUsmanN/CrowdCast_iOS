//
//  CCNavbarProtocol.swift
//  CrowdCast
//
//  Created by Usman on 01/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Kingfisher
import FirebaseStorage
import UIKit

protocol CCSetsNavbar : CCOpensSettings, CCImageStorage {}

extension CCSetsNavbar {
    
    /// Sets up navigation bar
    /// - Parameters:
    ///   - navigationBar: View Controller's navigation bar
    ///   - navigationItem: View Controller's navigation controller
    ///   - title: View Controller's title
    ///   - largeTitles: should prefer large titles
    ///   - profileAction: profile button action
    func setupNavBar(navigationBar: UINavigationBar?,navigationItem: UINavigationItem, title: String?, largeTitles: Bool, profileAction: Selector?){
        navigationItem.title                = title
        navigationBar?.prefersLargeTitles   = largeTitles
        let leftButton                      = getLogoButton()
        let profileButton                   = getProfileButton(action: profileAction)
        profileButton.action                = profileAction
        navigationItem.leftBarButtonItem    = leftButton
        navigationItem.setRightBarButtonItems([profileButton], animated: true)
    }
}


extension CCSetsNavbar {
    
    private func getLogoButton() -> UIBarButtonItem {
        let leftButton = UIBarButtonItem(title: "CROWD CAST (beta)", style: .plain, target: self, action: nil)
        leftButton.isEnabled = false
        leftButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Avenir", size: 13) as Any,
            NSAttributedString.Key.foregroundColor : UIColor.label as Any
        ], for: .disabled)
        return leftButton
    }
    
    private func getSearchButton() -> UIBarButtonItem {
        let searchView = UIImageView(image: #imageLiteral(resourceName: "Groups"))
        searchView.image = searchView.image?.withRenderingMode(.alwaysTemplate)
        searchView.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchButton = UIBarButtonItem(customView: searchView)
        return searchButton
    }
    
    private func getProfileButton(action: Selector?) -> UIBarButtonItem {
        let profileView = CCRoundButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        profileView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        profileView.contentMode = .scaleAspectFill
        profileView.layer.borderColor = UIColor(named: "Inverted")?.cgColor
        profileView.layer.borderWidth = 1
        
        getImage2(memberID: CCProfileManager.sharedInstance.getUID(), directory: .displays) { [weak self] response in
            switch response {
            case .success(let url):
                KingfisherManager.shared.retrieveImage(with: url) { result in
                    switch result {
                    case .success(let imageResult):
                        profileView.setImage(imageResult.image, for: .normal)
                    case .failure(let _):
                        print("Cannot fetch profile image")
                    }
                }
            case .failure(let _):
                print("Cannot fetch profile image")
                profileView.setImage(UIImage(named: "smily"), for: .normal)
            }
        }
        guard let action = action else { return UIBarButtonItem() }
        profileView.addTarget(self, action: action, for: .primaryActionTriggered)
        let profileButton = UIBarButtonItem(customView: profileView)
        return profileButton
    }
}
