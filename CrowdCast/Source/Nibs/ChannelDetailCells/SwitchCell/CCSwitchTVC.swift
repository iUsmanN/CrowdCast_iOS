//
//  CCSwitchTVC.swift
//  CrowdCast
//
//  Created by Usman on 22/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCSwitchTVC: UITableViewCell, CCContainsCellData {

    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var toggleSwitch     : UISwitch!
    
    var data                            : CCCellData? {
        didSet {
            titleLabel.text = data?.title
        }
    }
    
    @IBAction func switchPressed(_ sender: Any) {
        if toggleSwitch.isOn {
            data?.switchActions?.0?()
        } else {
            data?.switchActions?.1?()
        }
    }
}
