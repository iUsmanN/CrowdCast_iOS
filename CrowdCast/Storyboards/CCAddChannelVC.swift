//
//  CCAddChannelVC.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TweeTextField

class CCAddChannelVC: UIViewController {

    @IBOutlet weak var nameTextField        : TweeActiveTextField!
    @IBOutlet weak var descriptionTextField : TweeActiveTextField!
    @IBOutlet weak var ownerTextField       : TweeBorderedTextField!
    
    var viewModel = CCAddChannelVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func addChannel(_ sender: Any) {
        
    }
}

extension CCAddChannelVC {
    
    func setupView(){
        setupNavigationBar()
        ownerTextField
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Add Channel"
        navigationController?.navigationBar.isTranslucent = false
    }
}
