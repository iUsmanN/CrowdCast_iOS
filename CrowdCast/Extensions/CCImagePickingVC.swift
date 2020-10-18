//
//  CCImagePickingVC.swift
//  CrowdCast
//
//  Created by Usman on 07/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Kingfisher

class CCImagePickingVC: CCUIViewController {

    var imagePicker         = UIImagePickerController()
    var imagePickerDelegate : CCImagePickedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func pickImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension CCImagePickingVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) { [weak self] in
            guard let image = info[.editedImage] as? UIImage else { self?.imagePickerDelegate?.imageSelected(result: .failure(.ImageSelectionFailure)); return }
            ImageCache.default.store(KFCrossPlatformImage(data: image.pngData()!)!, forKey: Constants.imageCacheString(id: CCProfileManager.sharedInstance.getUID()))
            self?.imagePickerDelegate?.imageSelected(result: .success(image))
        }
    }
}

protocol CCImagePickedDelegate {
    func imageSelected(result: Result<UIImage, CCError>)
}
