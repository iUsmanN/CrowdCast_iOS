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

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func setupView(){
        
        showGreeting()
    }
}

extension CCOverviewVC {
    
    func showGreeting(){
        UIView.animate(withDuration: 0.75, delay: 2, options: .beginFromCurrentState, animations: {
            self.greetingHeight.constant = Device.size() > Size.screen4_7Inch ? 88 : 64
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
