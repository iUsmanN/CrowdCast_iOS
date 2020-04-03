//
//  CCSectionHeader.swift
//  CrowdCast
//
//  Created by Usman on 02/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCSectionHeader: UITableViewCell {
    
    @IBOutlet weak var headerLabel  : UILabel!
    @IBOutlet weak var rightButton  : UIButton!
    var rightButtonAction           : CardHeaderAction?
    
    var parentNavigationController  : UINavigationController?
    var data                        : CCSectionHeaderData?{
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        headerLabel.text  = data?.title
        rightButtonAction = data?.rightButtonAction
        rightButton.setTitle(data?.rightButtonTitle, for: .normal)
    }
    
    func setValues(data: CCSectionHeaderData, navigationController: UINavigationController?){
        self.data                       = data
        self.parentNavigationController = navigationController
    }
}

extension CCSectionHeader : CCAddChannel, CCJoinChannel {
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        
        switch rightButtonAction {
        case .newChannel:
            prints("newChannel")
            addChannel()
        case .newGroup:
            prints("newGroup")
        case .joinChannel:
            prints("joinChannel")
            joinChannel()
        case .joinGroup:
            prints("joinGroup")
        case .viewAll:
            prints("viewAll")
        default:
            prints("right button action not set")
        }
    }
}
