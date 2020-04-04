//
//  CCChannelsVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCChannelsVC: UIViewController {

    let viewModel = CCChannelsVM()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension CCChannelsVC : CCSetsNavbar {
    
    private func setupView(){
        setupNavBar(navigationBar   : navigationController?.navigationBar,
                    navigationItem  : navigationItem,
                    title           : "Channels",
                    profileAction   : #selector(viewSettings))
        setupTableView()
    }

    @objc private func viewSettings(){
        opensSettings()
    }
}

extension CCChannelsVC {
    
    private func setupTableView(){
        tableView.delegate      = self
        tableView.dataSource    = self
        let cardNib             = UINib(nibName: "CCCardTVCTableViewCell", bundle: nil)
        let sectionHeaderNib    = UINib(nibName: "CCSectionHeader", bundle: nil)
        
        tableView.register(cardNib, forCellReuseIdentifier: "CCCardTVCTableViewCell")
        tableView.register(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: "CCSectionHeader")
    }
}

extension CCChannelsVC : UITableViewDataSource, UITableViewDelegate, ShowsCardHeader {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CCCardTVCTableViewCell", for: indexPath) as? CCCardTVCTableViewCell else { return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.CardList.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cardHeader(data: viewModel.sectionHeader(section: section), parentNavigationController: self.navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.CardList.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

