//
//  CCAddChannelVC.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCAddChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension CCAddChannelVC {
    
    func setupView(){
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Add Channel"
        navigationController?.navigationBar.isTranslucent = false
    }
}
