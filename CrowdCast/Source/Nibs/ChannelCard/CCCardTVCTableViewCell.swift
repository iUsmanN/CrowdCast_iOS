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
    @IBOutlet weak var pingButton               : UIButton!
    
    var data : CCChannel? {
        didSet{
            titleLabel.text = data?.name
            CCUsersManager.sharedInstance.getUserNames(ids: data?.owners, completion: { (ownerNames) in
                guard let name = ownerNames.first else { return }
                DispatchQueue.main.async { [weak self] in self?.ownerLabel.text = name } })
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
    
    override func prepareForReuse() {
        membersCollectionView.reloadData()
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
    
    @IBAction func pinged(_ sender: Any) {
        generateHapticFeedback(.rigid)
    }
}

extension CCCardTVCTableViewCell {
    
    func setColors(color: String) {
        let c = UIColor(named: color)
        cardBackgroundView.layer.borderColor = c?.cgColor
        cardBackgroundView.layer.shadowColor = c?.cgColor
        titleLabel.textColor = c
        timeLabel.setView(inputColor: c)
        pingButton.setImage(#imageLiteral(resourceName: "Bell").withRenderingMode(.alwaysTemplate), for: .normal)
        pingButton.tintColor = c
    }
}

extension CCCardTVCTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, CCHapticEngine {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (data?.members?.count ?? 0) + (data?.owners?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: Nib.reuseIdentifier.CCCardMemberCell, for: indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        generateHapticFeedback(.light)
    }
}
