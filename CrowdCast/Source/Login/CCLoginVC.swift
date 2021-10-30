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
import IQKeyboardManagerSwift
import Lottie
import AuthenticationServices

class CCLoginVC: CCUIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    
    //    @IBOutlet weak var IllustrationTopGap: NSLayoutConstraint!
    //    @IBOutlet weak var IllustrationBottomGap: NSLayoutConstraint!
    
    @IBOutlet weak var curtainView: UIView!
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        emailIcon.image         = emailIcon.image?.withRenderingMode(.alwaysTemplate)
        passwordIcon.image      = passwordIcon.image?.withRenderingMode(.alwaysTemplate)
        emailIcon.alpha         = 0.7
        passwordIcon.alpha      = 0.7
        
        emailTextField.text     = "usmant4@gmail.com"
        passwordTextField.text  = "usmant4"
        
        //        IllustrationBottomGap.constant  = Device.size() > Size.screen4_7Inch ? 75 : 10
        //        IllustrationTopGap.constant     = Device.size() > Size.screen4_7Inch ? 60 : 20
        
        UIView.animate(withDuration: 0.75) { [weak self] in
            self?.curtainView.alpha = 0
        } completion: { (_) in }
        
        animationView.loopMode = .autoReverse
        animationView.contentMode = .center
        animationView.animationSpeed = 0.6
        animationView.play(completion: nil)
    }
    
    @IBAction func signInWithAppleTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension CCLoginVC : CCHapticEngine {
    
    @IBAction func joinPressed(_ sender: Any) {
        
    }
    
    @IBAction func loginPressed(_ sender: CCButton) {
        activeButton = sender
        pauseScreen()
        activeButton?.showSpinner()
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            signInFailed(error: CCError.emptyFields)
            return
        }
        signIn_Email(email: email, password: password)
        generateHapticFeedback(.soft)
    }
    
    @IBAction func joinWithGooglePressed(_ sender: Any) {
        generateHapticFeedback(.light)
        moveToHome()
    }
}

extension CCLoginVC {
    
    func signIn_Email(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard error == nil else { self?.signInFailed(error: error); return }
//            self?.signInSuccessFul(result: result)
        }
    }
}

extension CCLoginVC : CCSyncUserData, CCUserService {
    
    func signInFailed(error: Error?){
        activeButton?.hideSpinner()
        unpauseScreen()
        print("Can't sign in.")
    }
    
    func signInSuccessFul(result: AuthDataResult?, email: String, firstName: String, lastName: String){
        guard let uid = result?.user.uid else { return }
        print("Signed in.")
        generateHapticFeedback(.light)
        syncUserData(uid: uid) { [weak self](result) in
            switch result {
            case .success(_) :
                UIView.animate(withDuration: 0.75) { [weak self] in
                    self?.curtainView.alpha = 1
                } completion: { (_) in
                    self?.moveToHome()
                }
            case .failure(let error):
                self?.createUser(uid: uid, email: email, firstName: firstName, lastName: lastName)
            }
        }
    }
    
    func createUser(uid: String?, email: String, firstName: String, lastName: String){
        guard let uid = uid else { return }
        addNewUser(uid: uid, email: email, firstName: firstName, lastName: lastName) { [weak self](result) in
            switch result {
            case .success(_):
                self?.syncUserData(uid: uid) { [weak self](result) in
                    switch result {
                    case .success(_) :
                        UIView.animate(withDuration: 0.75) { [weak self] in
                            self?.curtainView.alpha = 1
                        } completion: { (_) in
                            self?.moveToHome()
                        }
                    case .failure(let error):
                        self?.signInFailed(error: error)
                    }
                }
            case .failure(let error):
                self?.signInFailed(error: error)
            }
        }
    }
}

extension CCLoginVC : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding, CCNonceGenerator {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let appleIDToken = appleIDCredential.identityToken, let idTokenString = String(data: appleIDToken, encoding: .utf8) else { return }
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: randomNonceString())
            
            let fullName = appleIDCredential.fullName!
            let email = appleIDCredential.email
            
            Auth.auth().signIn(with: credential) { [weak self] (result, error) in
                guard error == nil else { self?.signInFailed(error: error); return }
                self?.signInSuccessFul(result: result, email: email ?? (self!.readUserEmailInKeychain()), firstName: PersonNameComponentsFormatter().string(from: fullName) ?? "CC", lastName: "CC")
            }
            saveUserEmailInKeychain(email ?? "crowd@cast.com")
        default:
            break
        }
    }
    
    private func saveUserEmailInKeychain(_ email: String) {
        do {
            try KeychainItem(service: "com.iusmann.cyty", account: "email").saveItem(email)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    private func readUserEmailInKeychain() -> String {
        do {
            let email = try KeychainItem(service: "com.iusmann.cyty", account: "email").readItem()
            return email
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
        return "?"
    }
    
    func progressToHome(){
        print("Got to home")
    }
}
