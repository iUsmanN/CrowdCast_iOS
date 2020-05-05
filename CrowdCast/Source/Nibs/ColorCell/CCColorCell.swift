//
//  CCColorCell.swift
//  CrowdCast
//
//  Created by Usman on 25/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCColorCell: UICollectionViewCell {
    
    var color : UIColor? {
        didSet {
            backgroundColor = color
            layer.cornerRadius = bounds.size.width/2
//            layer.borderColor = UIColor.white.cgColor
//            layer.borderWidth = 2
        }
    }
}
