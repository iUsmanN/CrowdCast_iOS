//
//  CCSplashVC.swift
//  CrowdCast
//
//  Created by Usman on 27/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import FirebaseAuth
import Lottie

class CCSplashVC: UIViewController, CCSyncUserData {
    
    @IBOutlet weak var crowdCast: UILabel!
    @IBOutlet weak var backgroundGradient: AnimationView!
    let anim : AnimationView = .init(name: "lf20_nevctvni")//.init(name: "9395-background-gradient")//.init(name: "10989-gradient-1")
    @IBOutlet weak var bottomText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anim.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        anim.loopMode = .playOnce
        anim.animationSpeed = 2
        anim.contentMode = .scaleAspectFill
        self.backgroundGradient.addSubview(anim)
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
                        self.anim.play(fromFrame: 0, toFrame: 120, loopMode: .playOnce) { (_) in
                            UIView.transition(with: self.crowdCast, duration: 1, options: .transitionCrossDissolve) { [weak self] in
                                self?.crowdCast.textColor = UIColor(named: "Main Accent")
                                self?.crowdCast.alpha = 0
                                self?.bottomText.alpha = 0
                                self?.backgroundGradient.alpha = 0
                            } completion: { [weak self] (_) in
                                self?.moveToHome()
                            }
                        }
                    }
                    
                case .failure(let error): prints(error)
                }
            }
        } else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.crowdCast.textColor = UIColor(named: "Main Accent")
                    self?.crowdCast.alpha = 0
                    self?.bottomText.alpha = 0
                    self?.backgroundGradient.alpha = 0
                } completion: { (_) in self.moveToLogin()}
            }
        }
    }
}
