//
//  CCChannelDetailsVC.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Combine

class CCChannelDetailsVC: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    
    var viewModel : CCChannelDetailsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupView(inputData: CCChannel){
        viewModel = CCChannelDetailsVM(channelData: inputData)
    }
}

extension CCChannelDetailsVC {
    
    func bindVM(){
        
    }
}
