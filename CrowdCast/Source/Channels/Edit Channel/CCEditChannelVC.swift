//
//  CCEditChannelVC.swift
//  CrowdCast
//
//  Created by Usman on 07/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TweeTextField

class CCEditChannelVC: UIViewController {

    @IBOutlet weak var nameTextField        : TweeActiveTextField!
    @IBOutlet weak var descriptionTextField : TweeActiveTextField!
    @IBOutlet weak var foreignLinkTextField : TweeBorderedTextField!
    
    var viewModel                           = CCEditChannelVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView(){
        nameTextField.text          = viewModel.getChannelData()?.name
        descriptionTextField.text   = viewModel.getChannelData()?.description
        foreignLinkTextField.text   = viewModel.getChannelData()?.foreignLink
    }
}

extension CCEditChannelVC {
    
    @IBAction func savePressed(_ sender: Any) {
        viewModel.saveChanges(name: nameTextField.text, description: descriptionTextField.text, foreignLink: foreignLinkTextField.text) { [weak self] (result) in
            switch result {
            case .success(let updatedInfo):
                self?.editChannelDetails(updatedChannelInfo: updatedInfo)
                self?.editChannelJoin(updatedChannelInfo: updatedInfo)
                self?.refreshChannelsVC()
                DispatchQueue.main.async { self?.navigationController?.popViewController(animated: true) }
            case .failure(let error):
                prints(error)
            }
        }
    }
}

extension CCEditChannelVC {
    
    func editChannelDetails(updatedChannelInfo: CCChannel){
        guard let channelDetailsVC = navigationController?.viewControllers[(navigationController?.viewControllers.count ?? 2) - 2] as? CCChannelDetailsVC else { return }
        channelDetailsVC.viewModel?.data = updatedChannelInfo
    }
    
    func editChannelJoin(updatedChannelInfo: CCChannel){
        guard let joinChannelVC = navigationController?.viewControllers[(navigationController?.viewControllers.count ?? 2) - 3] as? CCJoinChannelVC else { return }
        joinChannelVC.viewModel?.data = updatedChannelInfo
    }
    
    func refreshChannelsVC() {
        if navigationController?.viewControllers[(navigationController?.viewControllers.count ?? 2) - 4] is CCChannelsVC {
            CCChannelsVC.refresh = true
        } else if navigationController?.viewControllers[(navigationController?.viewControllers.count ?? 2) - 4] is CCCrowdChannelsVC {
            CCCrowdChannelsVC.refresh = true
        }
    }
}
