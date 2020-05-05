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
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.red,
            NSAttributedString.Key.font : UIFont(name: "Avenir", size: 20)
        ]
    }
}
