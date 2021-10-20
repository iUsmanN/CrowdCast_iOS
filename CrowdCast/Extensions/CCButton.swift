//
//  CCButton.swift
//  CrowdCast
//
//  Created by Usman on 29/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class CCButton : UIButton {
    
    var animView = AnimationView()
    
    @IBInspectable var type : Int = 0 {
        didSet {
            titleLabel?.font = UIFont(name: "Avenir", size: 15)
            switch type {
            case 0: //main
                backgroundColor     = UIColor(named: "Main Accent")
                layer.cornerRadius  = 10
                setTitleColor(UIColor(named: "Background"), for: .normal)
                layer.masksToBounds = true
                addView()
                
            case 1: //secondary
                backgroundColor     = UIColor(named: "Background")
                backgroundColor     = UIColor(red: backgroundColor?.redValue ?? 0,
                                              green: backgroundColor?.greenValue ?? 0,
                                              blue: backgroundColor?.blueValue ?? 0,
                                              alpha: 0.3)
                layer.cornerRadius  = 10
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
        layer.borderColor   = UIColor.gray.cgColor
    }
    
    func greenBorder() {
        layer.borderColor   = UIColor(named: "blue")?.cgColor
    }
    
    func addView() {
        animView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        animView.backgroundColor            = backgroundColor
        animView.animation                  = Animation.named("8682-loading")
        animView.isHidden                   = true
        animView.isUserInteractionEnabled   = false
        animView.animationSpeed             = 3
        animView.loopMode                   = .loop
        DispatchQueue.main.async { self.addSubview(self.animView) }
        bringSubviewToFront(animView)
    }
    
    func showSpinner(){
        animView.play()
        animView.isHidden = false
    }
    
    func hideSpinner(){
        animView.stop()
        animView.isHidden = true
    }
}
