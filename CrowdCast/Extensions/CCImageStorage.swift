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

enum ImageCacheDirectory : String {
    case displays
    case groups
}

protocol CCImageStorage {}

extension CCImageStorage {
    
    
    /// Gets image cache URL
    /// - Parameter id: user ID
    /// - Returns: completion handler
    func imageCacheURL(id: String?, directory: ImageCacheDirectory = .displays) -> URL? {
        guard let id = id, let url = URL(string: Constants.imageCacheString(id: id, directory: directory)) else {
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
    
    /// Gets Group Image URL
    /// - Parameters:
    ///   - id: group ID
    ///   - result: completion handler
    /// - Returns: nil
    private func getImageUrl(cacheDirectory: ImageCacheDirectory, id: String?, result: @escaping (Result<URL?, Error>) -> ()) {
        Storage.storage().reference().child(cacheDirectory.rawValue).child("\(id ?? "").png").downloadURL { (url, error) in
            guard error == nil else { result(.success(nil)); return }
            result(.success(url))
        }
    }
    
    /// Uploads profile image
    /// - Parameters:
    ///   - image: new profile image
    ///   - result: completion handler
    /// - Returns: nil
    func uploadProfileImage(image: UIImage, result: @escaping (Result<UIImage?, CCError>) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 0.1) else { result(.failure(CCError.ImageUploadFailure)); return }
        Storage.storage().reference().child("displays").child("\(CCProfileManager.sharedInstance.getUID()).png").putData(uploadData, metadata: nil) { (_, error) in
            if error != nil { result(.failure(.ImageUploadFailure)) }
            guard let imageData = image.pngData(),
                let KFImage = KFCrossPlatformImage(data: imageData) else { result(.failure(.ImageCacheFailure)); return }
            ImageCache.default.store(KFImage, forKey: self.imageCacheURL(id: CCProfileManager.sharedInstance.getUID())?.absoluteString ?? "")
            NotificationCenter.default.post(name: .profilePictureChanged, object: nil)
            result(.success(image))
        }
    }
    
    /// Uploads group image
    /// - Parameters:
    ///   - image: new profile image
    ///   - result: completion handler
    /// - Returns: nil
    func uploadGroupImage(groupID: String, image: UIImage, result: @escaping (Result<UIImage?, CCError>) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 0.1) else { result(.failure(CCError.ImageUploadFailure)); return }
        Storage.storage().reference().child("groups").child("\(groupID).png").putData(uploadData, metadata: nil) { (_, error) in
            if error != nil { result(.failure(.ImageUploadFailure)) }
            guard let KFImage = KFCrossPlatformImage(data: uploadData) else { result(.failure(.ImageCacheFailure)); return }
            ImageCache.default.store(KFImage, forKey: self.imageCacheURL(id: groupID, directory: .groups)?.absoluteString ?? "")
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
    func getImage(memberID: String?, directory: ImageCacheDirectory = .displays, result: @escaping (Result<ImageResource, Error>)->()) {
        if let url = imageCacheURL(id: memberID, directory: directory), ImageCache.default.isCached(forKey: url.getQueryLessURL()?.absoluteString ?? "") {
            result(.success(ImageResource(downloadURL: url, cacheKey: url.getQueryLessURL()?.absoluteString)))
        }
        getImageUrl(cacheDirectory: directory, id: memberID) { (response) in
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
