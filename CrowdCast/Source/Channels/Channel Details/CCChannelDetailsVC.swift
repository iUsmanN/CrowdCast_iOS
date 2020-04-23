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
        
    }
    
}

extension CCChannelDetailsVC : CCGetsViewController, CCHapticEngine {
    
    @IBAction func joinCall(_ sender: Any) {
        let viewController = instantiateViewController(storyboard: .Channels, viewController: .CCCallScreenVC, as: CCCallScreenVC())
        viewController.setupViewModel(channelData: viewModel?.data)
        generateHapticFeedback(.light)
        DispatchQueue.main.async {  [weak self] in
            self?.present(viewController, animated: true, completion: nil)
        }
    }
}

extension CCChannelDetailsVC {
    
    func setupViewModel(inputData: CCChannel){
        viewModel = CCChannelDetailsVM(channelData: inputData)
    }
    
    func setupView(){
        tableView.dataSource = self
        tableView.delegate   = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel?.data.name
        tableView.register(Nib.get.CCSwitchTVC, forCellReuseIdentifier: Nib.reuseIdentifier.CCSwitchTVC)
    }
}

extension CCChannelDetailsVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reuseIdentifier.CCSwitchTVC, for: indexPath) as? CCSwitchTVC else { return UITableViewCell() }
        cell.data = viewModel?.dataForCell(indexPath: indexPath)
        return cell
    }
}
