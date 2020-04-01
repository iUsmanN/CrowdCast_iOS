//
//  CCNavbarProtocol.swift
//  CrowdCast
//
//  Created by Usman on 01/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCNavbarProtocol {}

extension CCNavbarProtocol {
    
    func setupNavBar(navigationItem: UINavigationItem, navigationController: UINavigationController?, title: String?){
        navigationItem.title = title
        
        let leftButton = getLogoButton()
        
        let searchButton = getSearchButton()
        let profileButton = getProfileButton()
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.setRightBarButtonItems([searchButton,profileButton], animated: true)
    }
}


extension CCNavbarProtocol {
    
    private func getLogoButton() -> UIBarButtonItem {
        let leftButton = UIBarButtonItem(title: "CROWD CAST", style: .plain, target: self, action: nil)
        leftButton.isEnabled = false
        leftButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Avenir", size: 12),
            NSAttributedString.Key.foregroundColor : UIColor(named: "Main Accent")
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
    
    private func getProfileButton() -> UIBarButtonItem {
        let profileView = UIImageView(image: #imageLiteral(resourceName: "Feed"))
        profileView.image = profileView.image?.withRenderingMode(.alwaysOriginal)
        profileView.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        let profileButton = UIBarButtonItem(customView: profileView)
        return profileButton
    }
}
