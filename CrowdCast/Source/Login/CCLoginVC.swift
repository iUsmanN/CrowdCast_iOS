//
//  CCLoginVC.swift
//  CrowdCast
//
//  Created by Usman on 22/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import FirebaseAuth
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
        UIApplication.shared.windows.first?.rootViewController = Constants.Storyboards.Home.instantiateViewController(withIdentifier: "CCTabBar")
    }
    
    @IBAction func joinWithGooglePressed(_ sender: Any) {
        
    }
    
    func setupView(){
        emailIcon.image = emailIcon.image?.withRenderingMode(.alwaysTemplate)
        passwordIcon.image = passwordIcon.image?.withRenderingMode(.alwaysTemplate)
        emailIcon.alpha = 0.7
        passwordIcon.alpha = 0.7
        
        emailTextField.text = "usman@usman.com"
        passwordTextField.text = "Passsssss"
        
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
        print("Signed in.")
    }
}
