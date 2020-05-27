//
//  CCSettingsVM.swift
//  CrowdCast
//
//  Created by Usman on 02/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit

struct CCSettingsVM {
    let data = [
        CCCellData(title: "Logout", titleColor: .red)
    ]
}

extension CCSettingsVM {
    
    func numberOfRows() -> Int {
        return data.count
    }
    
    func cellDataFor(indexPath: IndexPath) -> CCCellData {
        return data[indexPath.row]
    }
    
    func rowSelected(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            signOut()
        default:
            prints("Unhandled Row Selection")
        }
    }
}

extension CCSettingsVM : CCImageStorage {
    
    func updateProfilePicture(image: UIImage, result: @escaping (Result<UIImage?, CCError>)->()) {
        uploadProfileImage(image: image, result: result)
    }
}

extension CCSettingsVM : CCSyncUserData {
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            moveToLogin()
        } catch {
            prints("Error while Signing Out")
        }
    }
}
