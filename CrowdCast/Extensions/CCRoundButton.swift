//
//  CCRoundButton.swift
//  CrowdCast
//
//  Created by Usman on 26/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

class CCRoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10

    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = frame.size.width/2
    }
}
