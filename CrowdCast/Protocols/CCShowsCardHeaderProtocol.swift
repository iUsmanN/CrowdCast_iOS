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
    
    func cardHeader(data: CCSectionHeaderData, parentNavigationController: UINavigationController?) -> UIView {
        guard let header = Bundle.main.loadNibNamed("CCSectionHeader", owner: self, options: nil)?.first
        as? CCSectionHeader else { return UIView() }
        header.setValues(data: data, navigationController: parentNavigationController)
        return header
    }
}
