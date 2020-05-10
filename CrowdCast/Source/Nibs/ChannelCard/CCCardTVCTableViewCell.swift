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
                DispatchQueue.main.async { [weak self] in
                    self?.ownerLabel.text = ownerNames.compactMap({$0}).joined(separator: ", ")
                }})
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

extension CCCardTVCTableViewCell : CCHapticEngine {
    
    @IBAction func pinged(_ sender: Any) {
        generateHapticFeedback(.rigid)
        waveAnimation()
    }
    
    func waveAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.cardBackgroundView.backgroundColor = UIColor(named: self.data?.color ?? "red")
        }
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
            UIView.animate(withDuration: 0.5) {
                self.cardBackgroundView.backgroundColor = UIColor(named: "Foreground")
            }
        }
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

extension CCCardTVCTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (data?.members?.count ?? 0) + (data?.owners?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: Nib.reuseIdentifier.CCCardMemberCell, for: indexPath) as? CCCardMemberCell else { return UICollectionViewCell() }
        cell.memberID   = data?.allMembers[indexPath.row]
        return cell
    }
}
