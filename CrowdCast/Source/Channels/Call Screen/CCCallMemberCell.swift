//
//  CCCallMemberCell.swift
//  CrowdCast
//
//  Created by Usman on 16/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TwilioVideo

class CCCallMemberCell: UICollectionViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var participant: Participant?{
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        prints("Setup Call Cell View")
        nameLabel.text = participant?.identity
    }
}
