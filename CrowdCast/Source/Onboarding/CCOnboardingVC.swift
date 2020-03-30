//
//  CCOnboardingVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCOnboardingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishOnboarding(_ sender: Any) {
        UIApplication.shared.windows.first?.rootViewController = Constants.Storyboards.Home.instantiateViewController(withIdentifier: "CCTabBar")
    }
}
