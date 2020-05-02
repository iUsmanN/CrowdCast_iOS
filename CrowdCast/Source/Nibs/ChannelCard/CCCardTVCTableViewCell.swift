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
            timeLabel.text  = nil
            setupCollectionView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayers()
        setupView()
        setColors(color: "blue")
    }
    
    private func setupView() {
        membersCollectionView.register(Nib.nibFor(Nib.reuseIdentifier.CCCardMemberCell), forCellWithReuseIdentifier: Nib.reuseIdentifier.CCCardMemberCell)
    }
    
    private func setupLayers(){
        cardBackgroundView.layer.cornerRadius   = 10
        cardBackgroundView.layer.borderWidth    = 0.5
        cardBackgroundView.layer.shadowOpacity  = 0.2
        cardBackgroundView.layer.shadowOffset   = CGSize(width: 0, height: 3)
        selectionStyle = .none
    }
    
    private func setupCollectionView(){
        membersCollectionView.dataSource = self
        membersCollectionView.delegate   = self
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

extension CCCardTVCTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (data?.members?.count ?? 0) + (data?.owners?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: Nib.reuseIdentifier.CCCardMemberCell, for: indexPath)
    }
}
