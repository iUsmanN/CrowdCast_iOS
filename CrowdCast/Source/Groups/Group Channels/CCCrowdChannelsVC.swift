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
    static var refresh              = false
    var viewModel                   : CCCrowdChannelsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
}

extension CCCrowdChannelsVC : CCDynamicLinkEngine, CCDynamicLinkPreview{
    
    @IBAction func shareLinkPressed(_ sender: Any) {
        generateShareLink(input: viewModel?.crowdData) { [weak self](result) in
            switch result {
            case .success(let string):
                self?.previewDynamicLink(self?.viewModel?.bulletin, channelName: self?.viewModel?.crowdData?.name ?? "", deeplink: string ?? "", viewController: self)
            case .failure(let error):
                prints(error)
            }
        }
    }
}

extension CCCrowdChannelsVC {
    
    func setupView() {
        tableView.register(Nib.get.CCCardTVC, forCellReuseIdentifier: Nib.reuseIdentifier.CCCardTVC)
        tableView.register(Nib.get.CCSectionHeader, forCellReuseIdentifier: Nib.reuseIdentifier.CCSectionHeader)
        tableView.register(Nib.get.CCEmptyTableView, forHeaderFooterViewReuseIdentifier: Nib.reuseIdentifier.CCEmptyTableView)
        tableView.dataSource    = self
        tableView.delegate      = self
        title                   = viewModel?.crowdData?.name ?? ""
    }
    
    func setupViewModel(crowdData: CCCrowd?){
        viewModel = CCCrowdChannelsVM(crowdDataInput: crowdData)
    }
}

extension CCCrowdChannelsVC {
    
    func bindVM(){
        viewModel?.channelsPublisher.sink(receiveValue: { [weak self] (indexPathsInput) in
            guard let indexPaths = indexPathsInput.1 else { return }
            switch indexPathsInput.0 {
            case .insert:
                self?.insertRows(indexPaths: indexPaths)
            case .remove:
                self?.removeRows(indexPaths: indexPaths)
            case .refresh:
                self?.refreshRows()
            }
        }).store(in: &combineCancellable)
    }
    
    func insertRows(indexPaths: [IndexPath]){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func removeRows(indexPaths: [IndexPath]){
        
    }
    
    func refreshRows(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension CCCrowdChannelsVC : UITableViewDataSource, UITableViewDelegate, ShowsCardHeader, CCGetsViewController, CCHapticEngine {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reuseIdentifier.CCCardTVC, for: indexPath) as? CCCardTVCTableViewCell else { return UITableViewCell() }
        cell.isCrowdChannel = true
        cell.data = viewModel?.dataForRow(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let channelData = (viewModel?.dataForRow(indexPath: indexPath)) else { return }
        let vc = instantiateViewController(storyboard: .Channels, viewController: .CCJoinChannelVC, as: CCJoinChannelVC())
        vc.setupViewModel(inputData: channelData)
        generateHapticFeedback(.light)
        DispatchQueue.main.async { self.navigationController?.pushViewController(vc, animated: true) }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cardHeader(data: viewModel?.sectionHeaderData.first, parentNavigationController: self.navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.CardList.headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: Nib.reuseIdentifier.CCEmptyTableView)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return (viewModel?.channels.data.count ?? 0) > 0 ? 0 : 100
        default:
            return 0
        }
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

extension CCCrowdChannelsVC {
    
    func refreshData(){
        if(CCCrowdChannelsVC.refresh){
            viewModel?.fetchFreshData()
        }
    }
}
