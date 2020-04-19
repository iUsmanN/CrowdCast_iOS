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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func addChannel(_ sender: Any) {
        viewModel.addChannel(nameInput: nameTextField.text, descriptionInput: descriptionTextField.text) { [weak self] result in
            switch result {
            case .success(let channel):
                print(channel)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CCAddChannelVC {
    
    func setupView(){
        setupNavigationBar()
        ownerTextField.text = viewModel.channelOwner()
        nameTextField.delegate = self
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Add Channel"
        navigationController?.navigationBar.isTranslucent = false
    }
}

extension CCAddChannelVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        <#code#>
    }
}
