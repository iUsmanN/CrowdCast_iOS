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
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CCChannelsVM()
        setupView()
        bindVM()
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
            }}).store(in: &combineCancellable)
    }
    
    func insertRows(at indexPaths: [IndexPath]) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: indexPaths, with: .fade)
            self?.tableView.endUpdates()
            self?.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .fade)
        }
    }
    
    func removeRows(at indexPath: [IndexPath]) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: indexPath, with: .right)
            self?.tableView.endUpdates()
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
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cardHeader(data: viewModel?.sectionHeader(section: section), parentNavigationController: self.navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.CardList.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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
    
}
