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
        showGreeting()
    }
}

extension CCOverviewVC : CCNavbarProtocol {
    
    func showGreeting(){
        UIView.animate(withDuration: 0.75, delay: 0.75, options: .beginFromCurrentState, animations: {
            self.greetingHeight.constant = Device.size() > Size.screen4_7Inch ? 88 : 64
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension CCOverviewVC {
    
    @objc func openSettings(){
        print("Open Settings")
    }
}
