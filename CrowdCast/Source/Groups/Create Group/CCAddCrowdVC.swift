//
//  CCAddGroupVC.swift
//  CrowdCast
//
//  Created by Usman on 21/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TweeTextField

class CCAddCrowdVC: CCImagePickingVC {
    
    var viewModel                           = CCAddCrowdVM()
    
    @IBOutlet weak var nameTextField        : TweeActiveTextField!
    @IBOutlet weak var descriptionTextField : TweeActiveTextField!
    @IBOutlet weak var ownerTextField       : TweeBorderedTextField!
    @IBOutlet weak var groupPicture         : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func createChannel(_ sender: CCButton) {
        sender.showSpinner()
        pauseScreen()
        viewModel.addGroup(groupName: nameTextField.text, groupDescription: descriptionTextField.text, image: groupPicture.image) { [weak self](result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async { self?.navigationController?.popViewController(animated: true) }
            case .failure(let error):
                sender.hideSpinner()
                self?.unpauseScreen()
                prints(error)
            }
        }
    }
}

extension CCAddCrowdVC {
    
    func setupView(){
        setupNavigationBar()
        groupPicture.layer.cornerRadius = 15
        ownerTextField.text = "\(CCProfileManager.sharedInstance.getProfile()?.fullName() ?? "") (You)"
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Create Crowd"
    }
}

//Profile Image Change Action
extension CCAddCrowdVC : CCImagePickedDelegate {
    
    @IBAction func changeGroupPicture(_ sender: Any) {
        imagePickerDelegate = self
        pickImage()
    }
    
    func imageSelected(result: Result<UIImage, CCError>) {
        switch result {
        case .success(let image):
            groupPicture.image = image
        case .failure(let error):
            prints(error)
        }
    }
}
