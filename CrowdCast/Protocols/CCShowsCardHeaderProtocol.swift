//
//  CCShowsCardHeaderProtocol.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol ShowsCardHeader {}

extension ShowsCardHeader {
    
    /// Prepares List Card Section Header
    /// - Parameters:
    ///   - data: data for header
    ///   - parentNavigationController: parent controller
    /// - Returns: Section Header View
    func cardHeader(data: CCSectionHeaderData?, parentNavigationController: UINavigationController?) -> UIView {
        guard let header = Bundle.main.loadNibNamed("CCSectionHeader", owner: self, options: nil)?.first
        as? CCSectionHeader, let data = data else { return UIView() }
        header.setValues(data: data, navigationController: parentNavigationController)
        header.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let returnView = UIView(frame: header.frame)
        returnView.addSubview(header)
        return returnView
    }
}
