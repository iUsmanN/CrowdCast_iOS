//
//  CCLoginVC.swift
//  CrowdCast
//
//  Created by Usman on 22/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import FirebaseAuth

class CCLoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var IllustrationBottomGap: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        signIn_Email(email: "usman@usman.com", password: "Passsssss")
    }
    
    @IBAction func joinPressed(_ sender: Any) {
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
    }
    
    @IBAction func joinWithGooglePressed(_ sender: Any) {
        
    }
    
    func setupView(){
        emailTextField.text = "usman@usman.com"
        passwordTextField.text = "Passsssss"
        
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
