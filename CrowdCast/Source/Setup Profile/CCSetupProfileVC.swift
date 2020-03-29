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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
