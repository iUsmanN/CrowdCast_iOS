//
//  CCChannelDetailsVC.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Combine

class CCChannelDetailsVC: CCUIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    
    var viewModel : CCChannelDetailsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
        // Do any additional setup after loading the view.
    }
    
    func setupView(inputData: CCChannel){
        viewModel = CCChannelDetailsVM(channelData: inputData)
    }
}

extension CCChannelDetailsVC {
    
    
    func bindVM(){
        tempLabel.text = viewModel?.data.debugDescription()
        navigationItem.title = viewModel?.data.name
        viewModel?.titlePublisher.sink(receiveValue: { [weak self] (title) in
            self?.navigationItem.title = title
        }).store(in: &combineCancellable)
    }
}
