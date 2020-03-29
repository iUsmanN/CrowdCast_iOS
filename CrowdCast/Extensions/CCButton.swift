//
//  CCButton.swift
//  CrowdCast
//
//  Created by Usman on 29/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

class CCButton : UIButton {
    
    @IBInspectable var type : Int = 0 {
        didSet {
            switch type {
            case 0: //main
                backgroundColor = UIColor(named: "Main Accent")
                setTitleColor(UIColor(named: "Background"), for: .normal)
                layer.cornerRadius = 8
            case 1: //secondary
                backgroundColor = UIColor(named: "Background")
                setTitleColor(UIColor(named: "Main Accent"), for: .normal)
                layer.cornerRadius = 8
                layer.borderColor = UIColor(named: "Main Accent")?.cgColor
                layer.borderWidth = 1
            default: //error
                print("")
            }
        }
    }
    
}
