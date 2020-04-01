//
//  CCCardTVCTableViewCell.swift
//  CrowdCast
//
//  Created by Usman on 01/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCardTVCTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cardBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayers()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLayers(){
        cardBackgroundView.layer.cornerRadius = 10
        cardBackgroundView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        cardBackgroundView.layer.borderWidth = 0.5
        cardBackgroundView.layer.shadowOpacity = 0.1
        cardBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        selectionStyle = .none
    }
}
