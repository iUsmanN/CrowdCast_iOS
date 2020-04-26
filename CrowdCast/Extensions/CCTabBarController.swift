//
//  CCTabBarController.swift
//  CrowdCast
//
//  Created by Usman on 01/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        tabBar.tintColor = UIColor(named: "Main Accent")
        addBlur()
    }
    
    private func addBlur(){
        tabBar.backgroundImage = UIImage()
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blur.frame = tabBar.bounds
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(blur, at: 0)
    }
}
