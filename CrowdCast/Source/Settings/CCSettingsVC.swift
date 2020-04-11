//
//  CCSettingsVC.swift
//  CrowdCast
//
//  Created by Usman on 02/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Whisper

class CCSettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        setupNavBar()
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.isTranslucent = false
        let message = Message(title: "Enter your message here.", backgroundColor: .red)

        // Show and hide a message after delay
        Whisper.show(whisper: message, to: self.navigationController ?? UINavigationController(), action: .show)
    }
}
