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
            titleLabel?.font = UIFont(name: "Avenir", size: 15)
            switch type {
            case 0: //main
                backgroundColor     = UIColor(named: "Main Accent")
                layer.cornerRadius  = 10
                setTitleColor(UIColor(named: "Background"), for: .normal)
                
            case 1: //secondary
                backgroundColor     = UIColor(named: "Background")
                layer.cornerRadius  = 8
                layer.borderColor   = UIColor(named: "Main Accent")?.cgColor
                layer.borderWidth   = 1
                setTitleColor(UIColor(named: "Main Accent"), for: .normal)
            default: //error
                print("")
            }
        }
    }
    
}
