//
//  CCSplashVC.swift
//  CrowdCast
//
//  Created by Usman on 27/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import FirebaseAuth

class CCSplashVC: UIViewController, CCSyncUserData {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decideScreen()
    }
}

extension CCSplashVC {
    
    /// Decides what screen to present. Depends Upon whether the user is signed In
    func decideScreen(){
        if(Auth.auth().currentUser != nil){
            syncUserData(uid: Auth.auth().currentUser?.uid ?? "") { (result) in
                switch result {
                case .success(_)        : DispatchQueue.main.async { self.moveToHome();}
                case .failure(let error): prints(error)
                }
            }
        } else {
            moveToLogin()
        }
    }
}
