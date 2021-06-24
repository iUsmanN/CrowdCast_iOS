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
    
    @IBOutlet weak var crowdCast: UILabel!
    
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
                case .success(_)        :
                    DispatchQueue.main.async {
                        UIView.transition(with: self.crowdCast, duration: 1, options: .transitionCrossDissolve) { [weak self] in
                            self?.crowdCast.textColor = UIColor(named: "Main Accent")
                            self?.crowdCast.alpha = 0
                        } completion: { [weak self] (_) in
                            self?.moveToHome()
                        }
                    }
                    
                case .failure(let error): prints(error)
                }
            }
        } else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.crowdCast.textColor = UIColor(named: "Main Accent")
                } completion: { (_) in self.moveToLogin()}
            }
        }
    }
}
