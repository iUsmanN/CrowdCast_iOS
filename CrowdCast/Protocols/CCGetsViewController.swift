//
//  CCGetsViewController.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCGetsViewController {}

extension CCGetsViewController {
    
    /// Instantiates a new View Controller
    /// - Parameters:
    ///   - storyboard: Storyboard containing the view controller
    ///   - viewController: View controller Identifier
    ///   - as: View Controller class
    /// - Returns: View Controller Instance
    func instantiateViewController<T:UIViewController>(storyboard: Constants.StoryBoards, viewController: Constants.ViewControllers, as: T) -> T {
        guard let vc = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(identifier: viewController.rawValue) as? T else { return T() }
        return vc
    }
}
