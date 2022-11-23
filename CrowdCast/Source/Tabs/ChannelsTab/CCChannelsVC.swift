//
//  CCChannelsVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Combine

class CCChannelsVC: CCUIViewController {
    
    var viewModel : CCChannelsVM?
    static var refresh   = false
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CCChannelsVM()
        setupView()
        bindVM()
        viewModel?.enableDataListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.disableDataListener()
    }
}

extension CCChannelsVC : CCSetsNavbar {
    
    private func setupView(){
        setupNavBar(navigationBar   : navigationController?.navigationBar,
                    navigationItem  : navigationItem,
                    title           : "Channels",
                    largeTitles     : true,
                    profileAction   : #selector(viewSettings))
        setupTableView()
        addObservers()
    }
    
    @objc private func viewSettings(){
        opensSettings()
    }
}

extension CCChannelsVC {
    
    private func setupTableView(){
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.register(Nib.get.CCCardTVC, forCellReuseIdentifier: Nib.reuseIdentifier.CCCardTVC)
        tableView.register(Nib.get.CCEmptyTableView, forHeaderFooterViewReuseIdentifier: Nib.reuseIdentifier.CCEmptyTableView)
    }
}

extension CCChannelsVC {
    
    func bindVM(){
        viewModel?.channelsPublisher.sink(receiveValue: { [weak self] (indexPathsInput) in
            switch indexPathsInput.0 {
            case .insert:
                self?.insertRows(at: indexPathsInput.1)
            case .remove:
                self?.removeRows(at: indexPathsInput.1)
            case .refresh:
                self?.refreshRows()
            }}).store(in: &combineCancellable)
    }
    
    func insertRows(at indexPaths: [IndexPath]) {
        guard indexPaths.count > 0 else { return }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: indexPaths, with: .automatic)
            self?.tableView.endUpdates()
            self?.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
        }
    }
    
    func removeRows(at indexPath: [IndexPath]) {
        guard indexPath.count > 0 else { return }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: indexPath, with: .right)
            self?.tableView.endUpdates()
        }
    }
    
    func refreshRows(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension CCChannelsVC : UITableViewDataSource, UITableViewDelegate, ShowsCardHeader, CCGetsViewController, CCHapticEngine {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reuseIdentifier.CCCardTVC, for: indexPath) as? CCCardTVCTableViewCell else { return UITableViewCell()}
        cell.data = viewModel?.dataForCellAt(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let channelData = (viewModel?.dataForCellAt(indexPath: indexPath)) else { return }
        let vc = instantiateViewController(storyboard: .Channels, viewController: .CCJoinChannelVC, as: CCJoinChannelVC())
        vc.setupViewModel(inputData: channelData)
        generateHapticFeedback(.light)
        DispatchQueue.main.async { self.navigationController?.pushViewController(vc, animated: true) }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: Nib.reuseIdentifier.CCEmptyTableView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cardHeader(data: viewModel?.sectionHeader(section: section), parentNavigationController: self.navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.CardList.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return (viewModel?.myChannels.data.count ?? 0) > 0 ? 0 : 100
        case 1:
            return (viewModel?.joinedChannels.data.count ?? 0) > 0 ? 0 : 100
        default:
            return 0
        }
    }
}

extension CCChannelsVC : CCChannelActionDelegate {
    func channelAdded(data: CCChannel) {
        viewModel?.addCreatedChannel(channel: data)
    }
    
    func channelRemoved(data: CCChannel) {
        viewModel?.removeCreatedChannel(channel: data)
    }
}

extension CCChannelsVC {
    
    func addObservers(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: .profilePictureChanged,
                                               object: nil)
    }
    
    @objc func reloadData(){
        tableView.reloadData()
    }
    
    func refreshData(){
        if(CCChannelsVC.refresh){
            viewModel?.fetchFreshData()
        }
    }
}
