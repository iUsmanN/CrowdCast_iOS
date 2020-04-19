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
                layer.cornerRadius  = frame.size.height/2
                setTitleColor(UIColor(named: "Background"), for: .normal)
                
            case 1: //secondary
                backgroundColor     = UIColor(named: "Background")
                layer.cornerRadius  = frame.size.height/2
                layer.borderColor   = UIColor(named: "Main Accent")?.cgColor
                layer.borderWidth   = 0.5
                setTitleColor(UIColor(named: "Main Accent"), for: .normal)
            default: //error
                print("")
            }
        }
    }
    
}
