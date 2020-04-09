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

    @IBOutlet weak var firstNameInput   : UITextField!
    @IBOutlet weak var lastNameInput    : UITextField!
    @IBOutlet weak var emailInput       : UITextField!
    @IBOutlet weak var passwordInput    : UITextField!
    
    @IBOutlet weak var IllustrationTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
//    @IBAction func signUpPressed(_ sender: Any) {
//        signUp_Email(email: "abc@abc.com", password: "abcabc")
//    }
    
    @IBAction func joinFreePressed(_ sender: Any) {
        guard let email = emailInput.text, let password = passwordInput.text else { fieldsIncorrect(); return }
        signUp_Email(email: email, password: password)
    }
    
    
    func setupView(){
        IllustrationTopConstraint.constant = Device.size() > .screen4_7Inch ? 70 : 20
        
    }
}

extension CCSignUpVC {
    
    func signUp_Email(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { [weak self](result, error) in
            guard error == nil else { self?.signUpFailed(error: error); return }
            self?.createUser(uid: result?.user.uid)
        }
    }
}

extension CCSignUpVC : CCUserService {
    
    func createUser(uid: String?){
        guard let uid = uid else { return }
        addNewUser(uid: uid, email: emailInput.text, firstName: firstNameInput.text, lastName: lastNameInput.text) { [weak self](result) in
            switch result {
            case .success(_):
                self?.signUpSuccess(uid: uid)
            case .failure(let error):
                self?.signUpFailed(error: error)
            }
        }
    }
}

extension CCSignUpVC {
    
    func signUpFailed(error: Error?){
        print("sign up failed.")
    }
    
    func signUpSuccess(uid: String?){
        guard let uid = uid else { return }
        print("signed up successfully.")
        CCUserManager.sharedInstance.syncData(uid: uid){ callbackResult in
            
        }
    }
    
    func fieldsIncorrect(){
        
    }
    
    
}
