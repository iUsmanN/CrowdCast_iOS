//
//  CCDetailsSectionHeader.swift
//  CrowdCast
//
//  Created by Usman on 18/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCDetailsSectionHeader: UITableViewCell {

    @IBOutlet weak var headerTitle  : UILabel!
    var title                       : String? {
        didSet {
            headerTitle.text = title
        }
    }
}
