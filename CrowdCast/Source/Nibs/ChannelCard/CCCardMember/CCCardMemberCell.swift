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
    
    var storage = CCStoragerManager()
    var memberID : String? {
        didSet {
            storage.imageUrl(id: memberID ?? "") {[weak self] (result) in
                switch result{
                case .success(let url):
                    guard let url = url else { return }
                    self?.imageView.kf.setImage(with: ImageResource(downloadURL: url, cacheKey: url.getQueryLessURL()?.absoluteString))
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
        layer.borderWidth   = 0.5
        layer.borderColor   = UIColor.darkGray.cgColor
        layoutIfNeeded()
    }
}
