//
//  CCJoinChannelVC.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCJoinChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
}

extension CCJoinChannelVC {
    
    func setupView(){
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Join Channel"
        navigationController?.navigationBar.isTranslucent = false
    }
}
