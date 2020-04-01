//
//  CCOverviewVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Device

class CCOverviewVC: UIViewController {

    @IBOutlet weak var greetingView: CCNavBar!
    @IBOutlet weak var greetingHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        setupNavBar(navigationItem: navigationItem, title: "Overview", profileAction: #selector(openSettings))
        setupTableView()
    }
}

extension CCOverviewVC : CCNavbarProtocol {
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let cardNib = UINib(nibName: "CCCardTVCTableViewCell", bundle: nil)
        tableView.register(cardNib, forCellReuseIdentifier: "CCCardTVCTableViewCell")
    }
}

extension CCOverviewVC {
    
    @objc func openSettings(){
        print("Open Settings")
        navigationController?.pushViewController(Constants.Storyboards.Others.instantiateViewController(withIdentifier: "CCSettingsVC"), animated: true)
    }
}

extension CCOverviewVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CCCardTVCTableViewCell", for: indexPath) as? CCCardTVCTableViewCell else { return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}
