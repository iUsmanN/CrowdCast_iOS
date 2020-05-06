//
//  CCCardMemberCell.swift
//  CrowdCast
//
//  Created by Usman on 02/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCardMemberCell: UICollectionViewCell {

    var storage = CCStoragerManager()
    var memberID : String? {
        didSet {
            //get url
            storage.imageUrl(id: memberID ?? "") { (result) in
                switch result{
                case .success(let url):
                    //get image with kingfisher
                    prints("get image for \(url)")
                case .failure(let err):
                    prints(err)
                }
            }
        }
    }
    
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
