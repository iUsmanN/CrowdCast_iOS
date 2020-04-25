//
//  CCDetailsSegueTVC.swift
//  CrowdCast
//
//  Created by Usman on 23/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCDetailsSegueTVC: UITableViewCell, CCContainsCellData {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var data: CCCellData? {
        didSet {
            titleLabel.text = data?.title
        }
    }
    
}
