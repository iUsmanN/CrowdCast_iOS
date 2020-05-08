//
//  CCCardMemberCell.swift
//  CrowdCast
//
//  Created by Usman on 02/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Kingfisher

class CCCardMemberCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var memberID : String? {
        didSet {
            setImage(memberID: memberID) { [weak self] (result) in
                switch result {
                case .success(let imageResource):
                    self?.imageView.kf.setImage(with: imageResource, placeholder: #imageLiteral(resourceName: "avatarMale"))
                case .failure(let error):
                    prints(error)
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
        layer.borderWidth   = 0.5
        layer.borderColor   = UIColor.darkGray.cgColor
        layoutIfNeeded()
    }
}

extension CCCardMemberCell : CCImageStorage {}
