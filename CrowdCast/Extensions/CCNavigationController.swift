//
//  CCNavigationController.swift
//  CrowdCast
//
//  Created by Usman on 04/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationBar.tintColor = UIColor(named: "Main Accent")
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(named: "Inverted"),
            NSAttributedString.Key.font : UIFont(name: "Avenir", size: 20)
        ]
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(named: "Inverted"),
            NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 40)
        ]
    }
}
