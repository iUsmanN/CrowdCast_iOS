//
//  CCOverviewVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Device

class CCOverviewVC: UIViewController {

    @IBOutlet weak var greetingView: CCNavBar!
    @IBOutlet weak var greetingHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        setupNavBar(navigationItem: navigationItem, title: "Overview", profileAction: #selector(openSettings))
    }
}

extension CCOverviewVC : CCNavbarProtocol {
    
}

extension CCOverviewVC {
    
    @objc func openSettings(){
        print("Open Settings")
    }
}
