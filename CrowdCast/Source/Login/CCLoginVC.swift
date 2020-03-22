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

    override func viewDidLoad() {
        super.viewDidLoad()
        signIn_Email(email: "usman@usman.com", password: "Passsssss")
    }
    
    @IBAction func signIn(_ sender: Any) {
        signIn_Email(email: "usman@usman.com", password: "Passsssss")
    }
    
    @IBAction func signUp(_ sender: Any) {
        print("move to sign up")
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
