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
            imageView.kf.indicatorType = .activity
            if let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/crowdcast-31303.appspot.com/o/displays%2F\(memberID ?? "").png"){
                imageView.kf.setImage(with: url)
            }
            getProfileImageUrl(id: memberID ?? "") {[weak self] (result) in
                switch result{
                case .success(let url):
                    guard let url = url, let key = url.getQueryLessURL()?.absoluteString else { return }
                    self?.imageView.kf.setImage(with: ImageResource(downloadURL: url, cacheKey: key))
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

extension CCCardMemberCell : CCStoragerManager {}
