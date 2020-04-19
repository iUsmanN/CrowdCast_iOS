//
//  CCHapticEngine.swift
//  CrowdCast
//
//  Created by Usman on 19/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCHapticEngine {}

extension CCHapticEngine {
    
    func generateHapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
