//
//  CCTabBarController.swift
//  CrowdCast
//
//  Created by Usman on 01/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        tabBar.tintColor = UIColor(named: "Main Accent")
    }
}
