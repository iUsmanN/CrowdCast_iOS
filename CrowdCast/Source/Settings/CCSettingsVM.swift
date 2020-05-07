//
//  CCSettingsVM.swift
//  CrowdCast
//
//  Created by Usman on 02/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

struct CCSettingsVM {
    let data = [
        CCCellData(title: "Logout", titleColor: .red)
    ]
    var storage = CCStoragerManager()
}

extension CCSettingsVM {
    
    func numberOfRows() -> Int {
        return data.count
    }
    
    func cellDataFor(indexPath: IndexPath) -> CCCellData {
        return data[indexPath.row]
    }
}

extension CCSettingsVM {
    
    func updateProfilePicture(image: UIImage, result: @escaping (Result<UIImage?, Error>)->()) {
        storage.uploadProfileImage(image: image, result: result)
    }
}
