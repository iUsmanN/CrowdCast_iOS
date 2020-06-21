//
//  CCPauseScreen.swift
//  CrowdCast
//
//  Created by Usman on 16/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCPauseScreenProtocol : UIViewController {}

extension CCPauseScreenProtocol {
    
    /// Pauses the screen to prevevnt unnecessary taps.
    func pauseScreen() {
        unpauseScreen()
        let tagView = UIView(frame: view.frame)
        tagView.tag = 666
        tagView.backgroundColor = .red
        DispatchQueue.main.async { [weak self] in self?.view.addSubview(tagView) }
    }
    
    /// Unpauses the screen to work normally.
    func unpauseScreen() {
        if let tagView = view.viewWithTag(666) {
            DispatchQueue.main.async { tagView.removeFromSuperview() }
        }
    }
}
