//
//  CCCrowdCell.swift
//  CrowdCast
//
//  Created by Usman on 14/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCrowdCell: UICollectionViewCell {

    @IBOutlet weak var cardBackgroundView   : UIView!
    @IBOutlet weak var cardTitle            : UILabel!
    @IBOutlet weak var cardImage            : UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        // Initialization code
    }
    
    func setupView(){
        cardBackgroundView.layer.cornerRadius   = 10
        cardBackgroundView.layer.borderWidth    = 0.5
        cardBackgroundView.layer.borderColor    = UIColor.white.cgColor
        cardBackgroundView.layer.shadowOpacity  = 0.3
        cardBackgroundView.layer.shadowOffset   = CGSize(width: 0, height: 2)
    }

}
