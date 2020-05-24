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
    
    func setupView(){
        cardBackgroundView.layer.cornerRadius   = 10
        bgImage.layer.cornerRadius              = 10
        bgBlur.layer.cornerRadius               = 10
        cardBackgroundView.layer.borderWidth    = 0.5
        cardBackgroundView.layer.borderColor    = UIColor.white.cgColor
        cardBackgroundView.layer.shadowOpacity  = 0.3
        cardBackgroundView.layer.shadowOffset   = CGSize(width: 0, height: 2)
        cardImage.layer.cornerRadius            = 10
        bgImage.clipsToBounds                   = true
    }
    
    func setGroupImage(id: String?) {
        setImage(memberID: id ?? "", directory: .groups) { [weak self](result) in
            switch result {
            case .success(let imageResource):
                self?.cardImage.kf.setImage(with: imageResource)
                self?.bgImage.kf.setImage(with: imageResource)
            case .failure(let error):
                prints(error)
            }
        }
    }
}
