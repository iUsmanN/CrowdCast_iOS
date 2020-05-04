//
//  CCSettingsVC.swift
//  CrowdCast
//
//  Created by Usman on 02/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCSettingsVC: UIViewController {

    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var nameLabel    : UILabel!
    @IBOutlet weak var emailLabel   : UILabel!
    
    @IBOutlet weak var tableView    : UITableView!
    
    var viewModel                   : CCSettingsVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel = CCSettingsVM()
    }
    
    func setupView(){
        setupNavBar()
        setupProfileInfo()
        tableView.dataSource = self
        tableView.delegate   = self
        profileImage.layer.cornerRadius = 15
        tableView.register(Nib.get.CCTextCell, forCellReuseIdentifier: Nib.reuseIdentifier.CCTextCell)
        tableView.register(Nib.get.CCDetailsSegueTVC, forCellReuseIdentifier: Nib.reuseIdentifier.CCDetailsSegueTVC)
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupProfileInfo(){
        profileImage.layer.borderColor = UIColor(named: "Main Accent")?.cgColor
        profileImage.layer.borderWidth = 1.5
        nameLabel.text = CCProfileManager.sharedInstance.getProfile()?.fullName()
        emailLabel.text = CCProfileManager.sharedInstance.getProfile()?.email
    }
}

extension CCSettingsVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reuseIdentifier.CCTextCell, for: indexPath) as? CCTextCell else { return UITableViewCell() }
        cell.data = viewModel?.cellDataFor(indexPath: indexPath)
        cell.selectedBackgroundView = UIView()
        return cell
    }
}
