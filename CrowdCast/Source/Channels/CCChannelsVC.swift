//
//  CCChannelsVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCChannelsVC: UIViewController {

    @IBOutlet weak var greetingView: UIVisualEffectView!
    @IBOutlet weak var greetingViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIView.animate(withDuration: 0.25, delay: 2, options: .beginFromCurrentState, animations: {
            
            self.greetingView.alpha = 0
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.25) {
                
                self.greetingViewHeight.constant = 0
                self.view.layoutIfNeeded()
            }
        })
    }
}
