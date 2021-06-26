//
//  CCCrowdCell.swift
//  CrowdCast
//
//  Created by Usman on 14/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCrowdCell: UICollectionViewCell, CCImageStorage {
    
    @IBOutlet weak var cardBackgroundView   : UIView!
    @IBOutlet weak var cardTitle            : UILabel!
    @IBOutlet weak var cardImage            : UIImageView!
    @IBOutlet weak var bgImage              : UIImageView!
    @IBOutlet weak var bgBlur               : UIVisualEffectView!
    
    var data                                : CCCrowd? {
        didSet {
            cardTitle.text = data?.name
            setGroupImage(id: data?.id)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        bgImage.image   = nil
        cardImage.image = nil
        cardTitle.text  = nil
    }
    
    func setupView(){
        cardBackgroundView.layer.cornerRadius   = 10
        bgImage.layer.cornerRadius              = 10
        bgBlur.layer.cornerRadius               = 10
        cardBackgroundView.layer.borderWidth    = 0.5
        cardBackgroundView.layer.borderColor    = UIColor(named: "Inverted")?.cgColor
        cardBackgroundView.layer.shadowOpacity  = 0.3
        cardBackgroundView.layer.shadowOffset   = CGSize(width: 0, height: 2)
        cardImage.layer.cornerRadius            = 10
        bgImage.clipsToBounds                   = true
        contentView.layer.masksToBounds = true
        cardBackgroundView.layer.masksToBounds = true
    }
    
    func setGroupImage(id: String?) {
        getImage(memberID: id ?? "", directory: .groups, result: { [weak self](result) in
            switch result {
            case .success(let imageResource):
                self?.cardImage.kf.setImage(with: imageResource, placeholder: #imageLiteral(resourceName: "avatarFemale"), options: [.diskCacheExpiration(.seconds(604800))])
                self?.bgImage.kf.setImage(with: imageResource, placeholder: #imageLiteral(resourceName: "avatarFemale"), options: [.diskCacheExpiration(.seconds(604800))])
            case .failure(let error):
                prints(error)
            }
        })
    }
}
