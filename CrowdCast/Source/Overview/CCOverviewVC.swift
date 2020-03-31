//
//  CCOverviewVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCOverviewVC: UIViewController {

    @IBOutlet weak var greetingView: CCNavBar!
    @IBOutlet weak var greetingHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    func setupView(){
        showGreeting()
    }
}

extension CCOverviewVC {
    
    func showGreeting(){
        UIView.animate(withDuration: 1, delay: 2, options: .beginFromCurrentState, animations: {
            self.greetingView.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.75) {
                self.greetingHeight.constant = 0
                self.view.layoutIfNeeded()
            }
        })
    }
}
