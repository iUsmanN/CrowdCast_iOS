//
//  CCStoragerManager.swift
//  CrowdCast
//
//  Created by Usman on 06/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

struct CCStoragerManager {
    private var storage = Storage.storage().reference()
}

extension CCStoragerManager {
    
    func getProfileImageUrl(id: String?, result: @escaping (Result<URL?, Error>) -> ()) {
        storage.child("displays").child("\(id ?? "").png").downloadURL { (url, error) in
            guard error == nil else { result(.success(nil)); return }
            result(.success(url))
        }
    }
    
    func uploadProfileImage(image: UIImage, result: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { result(.failure(CCError.ImageUploadFailure)); return }
        storage.child("displays").child("\(CCProfileManager.sharedInstance.getUID()).png").putData(uploadData, metadata: nil) { (_, error) in
            if let error = error { result(.failure(error)) }
            result(.success(image))
        }
    }
}
