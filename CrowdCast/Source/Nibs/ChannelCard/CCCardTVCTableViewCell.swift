//
//  CCCardTVCTableViewCell.swift
//  CrowdCast
//
//  Created by Usman on 01/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCardTVCTableViewCell: UITableViewCell {

    @IBOutlet weak var cardBackgroundView       : UIView!
    @IBOutlet weak var titleLabel               : UILabel!
    @IBOutlet weak var timeLabel                : CCCardTimeLabel!
    @IBOutlet weak var ownerLabel               : UILabel!
    @IBOutlet weak var membersCollectionView    : UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayers()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupLayers(){
        cardBackgroundView.layer.cornerRadius   = 10
        cardBackgroundView.layer.borderWidth    = 1
        cardBackgroundView.layer.shadowOpacity  = 0.1
        cardBackgroundView.layer.shadowOffset   = CGSize(width: 0, height: 3)
        selectionStyle = .none
    }
    
    func setupView(){
        setColors(color: "CellBlue")
    }
}

extension CCCardTVCTableViewCell {
    
    func setColors(color: String) {
        let c = UIColor(named: color)
        cardBackgroundView.layer.borderColor = c?.cgColor
        titleLabel.textColor = c
        timeLabel.setView(inputColor: c)
    }
}
