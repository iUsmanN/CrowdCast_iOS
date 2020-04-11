//
//  CCSetupProfileVC.swift
//  CrowdCast
//
//  Created by Usman on 29/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCSetupProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        profileImage.layer.cornerRadius = profileImage.bounds.size.width / 2
        profileImage.layer.borderColor = UIColor(named: "Main Accent")?.cgColor
        profileImage.layer.borderWidth = 2
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        moveToOnboarding()
    }
    
    @IBAction func notNowPressed(_ sender: Any) {
        moveToOnboarding()
    }
    
}

extension CCSetupProfileVC : CCGetsViewController {
    
    func moveToOnboarding(){
        DispatchQueue.main.async { [weak self] in
            self?.present(self?.instantiateViewController(storyboard: .Onboarding, viewController: .CCOnboardingVC, as: CCOnboardingVC()) ?? UIViewController(), animated: true, completion: nil)
        }
//        present(Constants.Storyboards.Onboarding.instantiateViewController(withIdentifier: "CCOnboardingVC"), animated: true, completion: nil)
    }
}
