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
        layer.cornerRadius  = frame.size.width/2
        layer.borderWidth   = 2
        layer.borderColor   = UIColor(named: "Inverted")?.cgColor
    }
}
