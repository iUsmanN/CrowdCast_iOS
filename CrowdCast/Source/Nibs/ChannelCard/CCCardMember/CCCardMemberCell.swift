//
//  CCCardMemberCell.swift
//  CrowdCast
//
//  Created by Usman on 02/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCardMemberCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayers()
    }

    private func setupLayers(){
        layer.cornerRadius  = 17
        layer.borderWidth   = 0
        layer.borderColor   = UIColor(named: "Foreground")?.cgColor
        layoutIfNeeded()
    }
}
