//
//  CCCrowdChannelsVC.swift
//  CrowdCast
//
//  Created by Usman on 24/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Combine

class CCCrowdChannelsVC: CCUIViewController {
    
    @IBOutlet weak var tableView    : UITableView!
    
    var viewModel                   : CCCrowdChannelsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindVM()
    }
}

extension CCCrowdChannelsVC {
    
    func setupView() {
        tableView.register(Nib.get.CCCardTVC, forCellReuseIdentifier: Nib.reuseIdentifier.CCCardTVC)
        tableView.register(Nib.get.CCSectionHeader, forCellReuseIdentifier: Nib.reuseIdentifier.CCSectionHeader)
        tableView.dataSource    = self
        tableView.delegate      = self
        title                   = viewModel?.crowdData?.name ?? ""
        //navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupViewModel(crowdData: CCCrowd?){
        viewModel = CCCrowdChannelsVM(crowdDataInput: crowdData)
    }
}

extension CCCrowdChannelsVC {
    
    func bindVM(){
        viewModel?.channelsPublisher.sink(receiveValue: { (indexPathsInput) in
            switch indexPathsInput.0 {
            case .insert:
                self.insertRows(indexPaths: indexPathsInput.1)
            case .remove:
                self.removeRows(indexPaths: indexPathsInput.1)
            }
            }).store(in: &combineCancellable)
    }
    
    func insertRows(indexPaths: [IndexPath]){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.insertRows(at: indexPaths, with: .right)
        }
    }
    
    func removeRows(indexPaths: [IndexPath]){
    
    }
}

extension CCCrowdChannelsVC : UITableViewDataSource, UITableViewDelegate, ShowsCardHeader {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reuseIdentifier.CCCardTVC, for: indexPath) as? CCCardTVCTableViewCell else { return UITableViewCell() }
        cell.isCrowdChannel = true
        cell.data = viewModel?.dataForRow(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cardHeader(data: viewModel?.sectionHeaderData.first, parentNavigationController: self.navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.CardList.headerHeight
    }
}

extension CCCrowdChannelsVC : CCChannelActionDelegate {
    
    func channelAdded(data: CCChannel) {
        viewModel?.addCreatedChannel(channel: data)
    }
    
    func channelRemoved(data: CCChannel) {
        viewModel?.removeCreatedChannel(channel: data)
    }
}
