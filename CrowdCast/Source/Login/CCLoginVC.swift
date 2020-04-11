//
//  CCLoginVC.swift
//  CrowdCast
//
//  Created by Usman on 22/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Device

class CCLoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    
    @IBOutlet weak var IllustrationTopGap: NSLayoutConstraint!
    @IBOutlet weak var IllustrationBottomGap: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func joinPressed(_ sender: Any) {
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            signInFailed(error: CCError.emptyFields)
            return
        }
        signIn_Email(email: email, password: password)
        //UIApplication.shared.windows.first?.rootViewController = Constants.Storyboards.Home.instantiateViewController(withIdentifier: "CCTabBar")
    }
    
    @IBAction func joinWithGooglePressed(_ sender: Any) {
        
    }
    
    func setupView(){
        emailIcon.image = emailIcon.image?.withRenderingMode(.alwaysTemplate)
        passwordIcon.image = passwordIcon.image?.withRenderingMode(.alwaysTemplate)
        emailIcon.alpha = 0.7
        passwordIcon.alpha = 0.7
        
        emailTextField.text = "umer@gmail.com"
        passwordTextField.text = "umershafique"
        
        IllustrationBottomGap.constant = Device.size() > Size.screen4_7Inch ? 75 : 10
        IllustrationTopGap.constant = Device.size() > Size.screen4_7Inch ? 60 : 20
    }
    
}

extension CCLoginVC {
    
    func signIn_Email(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard error == nil else { self?.signInFailed(error: error); return }
            self?.signInSuccessFul(result: result)
        }
    }
}

extension CCLoginVC {
    
    func signInFailed(error: Error?){
        print("Can't sign in.")
    }
    
    func signInSuccessFul(result: AuthDataResult?){
        guard let uid = result?.user.uid else { return }
        print("Signed in.")
        syncUserData(uid: uid)
    }
}

extension CCLoginVC : CCGetsViewController{
    
    func syncUserData(uid: String){
        CCUserManager.sharedInstance.syncData(uid: uid){ [weak self] callbackResult in
            switch callbackResult {
            case .success(_)            : self?.moveToHome()
            case .failure(let error)    : self?.signInFailed(error: error)
            }
        }
    }
    
    func moveToHome(){
        UIApplication.shared.windows.first?.rootViewController =
        instantiateViewController(storyboard: .Home, viewController: .CCTabBar, as: CCTabBarController())
    }
}
