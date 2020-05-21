//
//  CCAddGroupVC.swift
//  CrowdCast
//
//  Created by Usman on 21/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TweeTextField

class CCAddGroupVC: CCImagePickingVC {
    
    var viewModel                           = CCAddGroupVM()
    
    @IBOutlet weak var nameTextField        : TweeActiveTextField!
    @IBOutlet weak var descriptionTextField : TweeActiveTextField!
    @IBOutlet weak var ownerTextField       : TweeBorderedTextField!
    @IBOutlet weak var groupPicture         : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

extension CCAddGroupVC {
    
    func setupView(){
        setupNavigationBar()
        groupPicture.layer.cornerRadius = 15
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Create Crowd"
    }
}

//Profile Image Change Action
extension CCAddGroupVC : CCImagePickedDelegate, CCImageStorage {
    
    @IBAction func changeGroupPicture(_ sender: Any) {
        imagePickerDelegate = self
        pickImage()
    }
    
    func imageSelected(result: Result<UIImage, CCError>) {
        switch result {
        case .success(let image):
            groupPicture.alpha = 0.2
//            viewModel?.updateProfilePicture(image: image, result: { [weak self] (result) in
//                switch result {
//                case .success(let image): self?.profileImage.image = image; self?.profileImage.alpha = 1
//                case .failure(let error): prints(error)
//                }
//            })
        case .failure(let error): prints(error)
        }
    }
}
