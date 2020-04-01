//
//  CCChannelsVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCChannelsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension CCChannelsVC : CCNavbarProtocol {
    
    func setupView(){
        setupNavBar(navigationItem: navigationItem, title: "Channels", profileAction: #selector(openSettings))
    }
}

extension CCChannelsVC {
    
    @objc func openSettings(){
        print("Open Settings")
    }
}
