//
//  CCStoragerManager.swift
//  CrowdCast
//
//  Created by Usman on 06/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseStorage

struct CCStoragerManager {
    private var storage = Storage.storage().reference()
}

extension CCStoragerManager {
    
    func imageUrl(id: String?, result: @escaping (Result<URL?, Error>) -> ()) {
        storage.child("displays").child("\(id ?? "").png").downloadURL { (url, error) in
            guard error == nil else { result(.success(nil)); return }
            result(.success(url))
        }
    }
}
