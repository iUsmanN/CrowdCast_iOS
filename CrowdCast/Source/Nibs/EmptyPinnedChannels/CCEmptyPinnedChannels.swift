//
//  CCEmptyPinnedChannels.swift
//  CrowdCast
//
//  Created by Usman on 14/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCEmptyPinnedChannels: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .yellow
    }
}
