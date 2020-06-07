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
                layer.cornerRadius  = 10//frame.size.height/2
                setTitleColor(UIColor(named: "Background"), for: .normal)
                
            case 1: //secondary
                backgroundColor     = UIColor(named: "Background")
                backgroundColor     = UIColor(red: backgroundColor?.redValue ?? 0,
                                              green: backgroundColor?.greenValue ?? 0,
                                              blue: backgroundColor?.blueValue ?? 0,
                                              alpha: 0.3)
                layer.cornerRadius  = 10//frame.size.height/2
                layer.borderColor   = UIColor(named: "Main Accent")?.cgColor
                layer.borderWidth   = 0.5
                setTitleColor(UIColor(named: "Main Accent"), for: .normal)
                
            case 2:
                backgroundColor     = UIColor(named: "Inverted")
                layer.borderColor   = UIColor(named: "green")?.cgColor
                layer.cornerRadius  = 10
                layer.borderWidth   = 1
                backgroundColor     = UIColor(red: backgroundColor?.redValue ?? 0,
                                              green: backgroundColor?.greenValue ?? 0,
                                              blue: backgroundColor?.blueValue ?? 0,
                                              alpha: 0.3)
            default:
                print("")
            }
        }
    }
    
    func redBorder() {
        layer.borderColor   = UIColor(named: "red")?.cgColor
    }
    
    func greenBorder() {
        layer.borderColor   = UIColor(named: "green")?.cgColor
    }
    
}
