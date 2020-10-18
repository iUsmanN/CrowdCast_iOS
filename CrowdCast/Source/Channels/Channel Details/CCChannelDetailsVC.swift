//
//  CCChannelDetailsVC.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TwilioVideo

class CCChannelDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView    : UITableView!
    var viewModel                   : CCChannelDetailsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "Main Accent")
    }
}

extension CCChannelDetailsVC : CCGetsViewController, CCHapticEngine {
    
    @IBAction func editChannelPressed(_ sender: Any) {
        let vc = instantiateViewController(storyboard: .Channels, viewController: .CCEditChannelVC, as: CCEditChannelVC())
        vc.viewModel.data = viewModel?.data
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CCChannelDetailsVC {
    
    func setupViewModel(inputData: CCChannel?){
        viewModel = CCChannelDetailsVM(channelData: inputData)
    }
    
    func setupView(){
        tableView.dataSource = self
        tableView.delegate   = self
        navigationItem.title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(Nib.get.CCSwitchTVC,         forCellReuseIdentifier: Nib.reuseIdentifier.CCSwitchTVC)
        tableView.register(Nib.get.CCDetailsSegueTVC,   forCellReuseIdentifier: Nib.reuseIdentifier.CCDetailsSegueTVC)
        tableView.register(Nib.get.CCTextCell,          forCellReuseIdentifier: Nib.reuseIdentifier.CCTextCell)
        tableView.register(Nib.get.CCTableViewHeader,   forCellReuseIdentifier: Nib.reuseIdentifier.CCTableViewHeader)
        tableView.register(Nib.get.CCDetailsSectionHeader, forCellReuseIdentifier: Nib.reuseIdentifier.CCDetailsSectionHeader)
    }
}

extension CCChannelDetailsVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reuseIdentifier.CCDetailsSectionHeader) as? CCDetailsSectionHeader else { return UITableViewCell() }
        cell.title = viewModel?.sectionTitle(section: section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                case (viewModel?.channelRows.count ?? 1) - 1:
                return dequeueCell(identifier: Nib.reuseIdentifier.CCTextCell, indexPath: indexPath, type: CCTextCell())
            default:
                return dequeueCell(identifier: Nib.reuseIdentifier.CCDetailsSegueTVC, indexPath: indexPath, type: CCDetailsSegueTVC())
            }
        case 1:
            switch indexPath.row {
            case (viewModel?.adminRows.count ?? 1) - 1:
                return dequeueCell(identifier: Nib.reuseIdentifier.CCTextCell, indexPath: indexPath, type: CCTextCell())
            default:
                return dequeueCell(identifier: Nib.reuseIdentifier.CCDetailsSegueTVC, indexPath: indexPath, type: CCDetailsSegueTVC())
            }
            
        default:
            prints("Unhandled Section: \(indexPath.section) in \(#function)")
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            default:
                prints("Unhandled Row: \(indexPath.row) in \(#function)")
            }
        case 1:
            switch indexPath.row {
            case (viewModel?.adminRows.count ?? 1) - 1:
                delete()
            default:
                prints("Unhandled Row: \(indexPath.row) in \(#function)")
            }
        default:
            prints("Unhandled Section: \(indexPath.section) in \(#function)")
        }
    }
}

extension CCChannelDetailsVC {
    
    func dequeueCell<T: CCContainsCellData>(identifier: String, indexPath: IndexPath, type: T) -> UITableViewCell {
        if var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            cell.data = viewModel?.dataForCell(indexPath: indexPath)
            guard let cell = cell as? UITableViewCell else { return UITableViewCell() }
            let bgView = UIView(); bgView.backgroundColor = .clear
            cell.selectedBackgroundView = bgView
            return cell
        }
        return UITableViewCell()
    }
}

extension CCChannelDetailsVC {
    
    func delete(){
        viewModel?.deleteChannel(completion: { (result) in
            switch result {
            case .success(let channel):
                guard let parentVC = self.navigationController?.viewControllers.first as? CCChannelActionDelegate else { return }
                parentVC.channelRemoved(data: channel)
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                    self?.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                prints("Error: \(error)")
            }
        })
    }
}
