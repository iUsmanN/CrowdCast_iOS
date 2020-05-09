//
//  CCJoinChannelVC.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCJoinChannelVC: UIViewController {

    var viewModel : CCJoinChannelVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
}

extension CCJoinChannelVC : CCGetsViewController, CCHapticEngine {
    
    @IBAction func channelDetailsPressed(_ sender: Any) {
        let vc = instantiateViewController(storyboard: .Channels, viewController: .ChannelDetails, as: CCChannelDetailsVC())
        vc.setupViewModel(inputData: viewModel?.getData())
        generateHapticFeedback(.light)
        DispatchQueue.main.async { self.navigationController?.pushViewController(vc, animated: true) }
    }
}

extension CCJoinChannelVC {
    
    func setupView(){
        setupNavigationBar()
    }
    
    func setupViewModel(inputData: CCChannel){
        viewModel = CCJoinChannelVM(channel: inputData)
    }
    
    func setupNavigationBar(){
        navigationItem.title = viewModel?.channelName() ?? ""
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .clear
    }
}
