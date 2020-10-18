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
            setImage()
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

extension CCCardMemberCell : CCImageStorage {
    
    func setImage(){
        getImage(memberID: memberID) { [weak self] (result) in
            switch result {
            case .success(let imageResource):
                if(self?.memberID == CCProfileManager.sharedInstance.getUID()) {
                    self?.imageView.kf.setImage(with: imageResource, placeholder: #imageLiteral(resourceName: "avatarMale"), options: [.diskCacheExpiration(.never)])
                } else {
                    self?.imageView.kf.setImage(with: imageResource, placeholder: #imageLiteral(resourceName: "avatarMale"), options: [.diskCacheExpiration(.seconds(172800))])
                }
            case .failure(let error):
                prints(error)
            }
        }
    }
}
