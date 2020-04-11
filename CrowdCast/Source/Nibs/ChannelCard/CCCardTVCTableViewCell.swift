//
//  CCCardTVCTableViewCell.swift
//  CrowdCast
//
//  Created by Usman on 01/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCardTVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardBackgroundView       : UIView!
    @IBOutlet weak var titleLabel               : UILabel!
    @IBOutlet weak var timeLabel                : CCCardTimeLabel!
    @IBOutlet weak var ownerLabel               : UILabel!
    @IBOutlet weak var membersCollectionView    : UICollectionView!
    
    var data : CCChannel? {
        didSet{
            titleLabel.text = data?.name
            ownerLabel.text = data?.owners?.first
            setColors(color: data?.color ?? "red")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayers()
        setColors(color: "blue")
    }
    
    private func setupLayers(){
        cardBackgroundView.layer.cornerRadius   = 10
        cardBackgroundView.layer.borderWidth    = 1
        cardBackgroundView.layer.shadowOpacity  = 0.2
        cardBackgroundView.layer.shadowOffset   = CGSize(width: 0, height: 3)
        selectionStyle = .none
    }
    
    func setupCell(channelData: CCChannel){
        titleLabel.text = channelData.name ?? ""
        ownerLabel.text = channelData.owners.flatMap({$0})?.joined(separator: ", ")
        timeLabel.text  = "01:00pm"
        setColors(color: channelData.color ?? "Main Accent")
    }
}

extension CCCardTVCTableViewCell {
    
    func setColors(color: String) {
        let c = UIColor(named: color)
        cardBackgroundView.layer.borderColor = c?.cgColor
        cardBackgroundView.layer.shadowColor = c?.cgColor
        titleLabel.textColor = c
        timeLabel.setView(inputColor: c)
    }
}
