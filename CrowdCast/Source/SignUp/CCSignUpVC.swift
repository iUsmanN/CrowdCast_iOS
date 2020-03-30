//
//  CCSignUpVC.swift
//  CrowdCast
//
//  Created by Usman on 22/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import FirebaseAuth
import Device

class CCSignUpVC: UIViewController {

    @IBOutlet weak var IllustrationTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    @IBAction func signUpPressed(_ sender: Any) {
        signUp_Email(email: "abc@abc.com", password: "abcabc")
    }
    
    func setupView(){
        IllustrationTopConstraint.constant = Device.size() > .screen4_7Inch ? 70 : 20
        
    }
}

extension CCSignUpVC {
    
    func signUp_Email(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { [weak self](result, error) in
            guard error == nil else { self?.signUpFailed(error: error); return }
            self?.signUpSuccess(result: result)
        }
    }
}

extension CCSignUpVC {
    
    func signUpFailed(error: Error?){
        print("sign up failed.")
    }
    
    func signUpSuccess(result: AuthDataResult?){
        print("signed up successfully.")
    }
}
