//
//  CCCollectionSectionHeader.swift
//  CrowdCast
//
//  Created by Usman on 20/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCollectionSectionHeader: UICollectionReusableView {

    @IBOutlet weak var title        : UILabel!
    @IBOutlet weak var rightButton  : UIButton!
    var rightButtonAction           : CardHeaderAction?
    
    static var bulletin             = CCBulletinManager()
    var parentNavigationController  : UINavigationController?
    var data                        : CCSectionHeaderData?{
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        title.text  = data?.title
        rightButtonAction = data?.rightButtonAction
        rightButton.setTitle(data?.rightButtonTitle, for: .normal)
    }
    
    func setValues(data: CCSectionHeaderData, navigationController: UINavigationController?){
        self.data                       = data
        self.parentNavigationController = navigationController
        CCSectionHeader.bulletin.manager?.backgroundViewStyle = .blurred(style: .regular, isDark: false)
    }
}

extension CCCollectionSectionHeader : CCAddGroup {
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        switch rightButtonAction {
        case .joinGroup:
            prints("join group")
        case .newGroup:
            addGroup()
        default:
            prints("Unhandled Section Header Item")
        }
    }
    
}
