//
//  CCTextCell.swift
//  CrowdCast
//
//  Created by Usman on 25/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCTextCell: UITableViewCell, CCContainsCellData {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var data: CCCellData? {
        didSet {
            titleLabel.text = data?.title
            valueLabel.text = data?.value
            if data?.titleColor != nil { titleLabel.textColor = data?.titleColor }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
