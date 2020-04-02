//
//  CCCrowdsVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCrowdsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
}

extension CCCrowdsVC : CCNavbarProtocol {
    
    func setupView(){
        setupNavBar(navigationBar   : navigationController?.navigationBar,
                    navigationItem  : navigationItem,
                    title           : "Crowds",
                    profileAction   : #selector(viewSettings))
    }

    @objc func viewSettings(){
        opensSettings()
    }
}
