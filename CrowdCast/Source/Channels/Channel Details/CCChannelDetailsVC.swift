//
//  CCChannelDetailsVC.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCChannelDetailsVC: UIViewController {

    var viewModel : CCChannelDetailsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension CCChannelDetailsVC {
    
    func setupViewModel(inputData: CCChannel){
        viewModel = CCChannelDetailsVM(channelData: inputData)
    }
    
    func setupView(){
        navigationItem.title = viewModel?.data.name
    }
}
