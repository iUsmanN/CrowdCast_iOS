//
//  CCNavbarProtocol.swift
//  CrowdCast
//
//  Created by Usman on 01/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCSetsNavbar : CCOpensSettings {}

extension CCSetsNavbar {
    
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
        let leftButton = UIBarButtonItem(title: "CROWD CAST", style: .plain, target: self, action: nil)
        leftButton.isEnabled = false
        leftButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Avenir", size: 12) as Any,
            NSAttributedString.Key.foregroundColor : UIColor(named: "Main Accent") as Any
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
        let profileView = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        profileView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileView.setImage(#imageLiteral(resourceName: "profile2.png"), for: .normal)
        guard let action = action else { return UIBarButtonItem() }
        profileView.addTarget(self, action: action, for: .primaryActionTriggered)
        let profileButton = UIBarButtonItem(customView: profileView)
        return profileButton
    }
}
