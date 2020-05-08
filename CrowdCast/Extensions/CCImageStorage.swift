//
//  CCStoragerManager.swift
//  CrowdCast
//
//  Created by Usman on 06/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import FirebaseStorage

protocol CCImageStorage {}

extension CCImageStorage {
    
    
    /// Gets image cache URL
    /// - Parameter id: user ID
    /// - Returns: completion handler
    func imageCacheURL(id: String?) -> URL? {
        guard let id = id, let url = URL(string: Constants.imageCacheString(id: id)) else {
            return nil
        }
        return url
    }
    
    /// Gets Logged In User Profile URL
    /// - Parameters:
    ///   - id: member ID
    ///   - result: completion handler
    /// - Returns: nil
    private func getProfileImageUrl(id: String?, result: @escaping (Result<URL?, Error>) -> ()) {
        Storage.storage().reference().child("displays").child("\(id ?? "").png").downloadURL { (url, error) in
            guard error == nil else { result(.success(nil)); return }
            result(.success(url))
        }
    }
    
    /// Uploads profile image
    /// - Parameters:
    ///   - image: new profile image
    ///   - result: completion handler
    /// - Returns: nil
    func uploadProfileImage(image: UIImage, result: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { result(.failure(CCError.ImageUploadFailure)); return }
        Storage.storage().reference().child("displays").child("\(CCProfileManager.sharedInstance.getUID()).png").putData(uploadData, metadata: nil) { (_, error) in
            if let error = error { result(.failure(error)) }
            result(.success(image))
        }
    }
}

extension CCImageStorage {
    
    /// Gets Image Resuource to set image using KingFisher
    /// - Parameters:
    ///   - memberID: member ID
    ///   - result: completion Handler
    /// - Returns: nil
    func setImage(memberID: String?, result: @escaping (Result<ImageResource, Error>)->()) {
        if let url = imageCacheURL(id: memberID) {
            result(.success(ImageResource(downloadURL: url, cacheKey: url.getQueryLessURL()?.absoluteString)))
        }
        getProfileImageUrl(id: memberID) { (response) in
            switch response {
            case .success(let url):
                guard let url = url, let key = url.getQueryLessURL()?.absoluteString else { return }
                result(.success(ImageResource(downloadURL: url, cacheKey: key)))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
