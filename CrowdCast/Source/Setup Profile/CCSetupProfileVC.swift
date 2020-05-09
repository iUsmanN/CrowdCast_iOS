//
//  CCSetupProfileVC.swift
//  CrowdCast
//
//  Created by Usman on 29/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCSetupProfileVC: CCImagePickingVC {

    @IBOutlet weak var profileImage     : UIImageView!
    
    var viewModel                       = CCSetupProfileVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        profileImage.layer.cornerRadius = profileImage.bounds.size.width / 2
        profileImage.layer.borderColor = UIColor(named: "Main Accent")?.cgColor
        profileImage.layer.borderWidth = 2
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        uploadImage()
    }
    
    @IBAction func notNowPressed(_ sender: Any) {
        moveToOnboarding()
    }
    
    @IBAction func selectImage(_ sender: Any) {
        imagePickerDelegate = self
        pickImage()
    }
}

extension CCSetupProfileVC : CCGetsViewController {
    
    func moveToOnboarding(){
        DispatchQueue.main.async { [weak self] in
            self?.present(self?.instantiateViewController(storyboard: .Onboarding, viewController: .CCOnboardingVC, as: CCOnboardingVC()) ?? UIViewController(), animated: true, completion: nil)
        }
    }
}

extension CCSetupProfileVC : CCImagePickedDelegate {
    
    func imageSelected(result: Result<UIImage, CCError>) {
        switch result {
        case .success(let image):
            profileImage.image = image
        case .failure(let error):
            prints(error)
        }
    }
    
    func uploadImage() {
        guard let image = profileImage.image else { return }
        viewModel.uploadProfileImage(image: image) { [weak self](result) in
            switch result {
            case .success(_):
                self?.moveToOnboarding()
            case .failure(let error):
                prints(error)
            }
        }
    }
}
