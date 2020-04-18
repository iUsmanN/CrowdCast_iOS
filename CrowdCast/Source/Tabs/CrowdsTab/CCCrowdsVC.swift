//
//  CCCrowdsVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCrowdsVC: CCUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
}

extension CCCrowdsVC : CCSetsNavbar {
    
    private func setupView(){
        setupNavBar(navigationBar   : navigationController?.navigationBar,
                    navigationItem  : navigationItem,
                    title           : "Crowds",
                    largeTitles     : true,
                    profileAction   : #selector(viewSettings))
    }

    @objc private func viewSettings(){
        opensSettings()
    }
}
