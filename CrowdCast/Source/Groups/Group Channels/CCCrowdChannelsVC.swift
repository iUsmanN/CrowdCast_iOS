//
//  CCCrowdChannelsVC.swift
//  CrowdCast
//
//  Created by Usman on 24/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCrowdChannelsVC: UIViewController {
    
    @IBOutlet weak var tableView    : UITableView!
    
    var viewModel                   : CCCrowdChannelsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
}

extension CCCrowdChannelsVC {
    
    func setupView() {
        tableView.register(Nib.get.CCCardTVC, forCellReuseIdentifier: Nib.reuseIdentifier.CCCardTVC)
        tableView.register(Nib.get.CCSectionHeader, forCellReuseIdentifier: Nib.reuseIdentifier.CCSectionHeader)
        tableView.dataSource    = self
        tableView.delegate      = self
        title                   = viewModel?.crowdData?.name ?? "L"
    }
    
    func setupViewModel(crowdData: CCCrowd?){
        viewModel = CCCrowdChannelsVM(crowdDataInput: crowdData)
    }
}

extension CCCrowdChannelsVC : UITableViewDataSource, UITableViewDelegate, ShowsCardHeader {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reuseIdentifier.CCCardTVC, for: indexPath) as? CCCardTVCTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cardHeader(data: viewModel?.sectionHeaderData.first, parentNavigationController: self.navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.CardList.headerHeight
    }
}
