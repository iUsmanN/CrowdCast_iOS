//
//  CCCrowdsVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCrowdsVC: CCUIViewController {
    
    @IBOutlet weak var collectionView   : UICollectionView!
    
    var viewModel                       : CCCrowdsVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupVM()
        // Do any additional setup after loading the view.
    }
}

extension CCCrowdsVC : CCSetsNavbar {
    
    private func setupVM(){
        viewModel = CCCrowdsVM()
    }
    
    private func setupView(){
        setupNavBar(navigationBar   : navigationController?.navigationBar,
                    navigationItem  : navigationItem,
                    title           : "Crowds",
                    largeTitles     : true,
                    profileAction   : #selector(viewSettings))
        collectionView.dataSource   = self
        collectionView.delegate     = self
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        collectionView.register(Nib.nibFor(Nib.reuseIdentifier.CCCrowdCell), forCellWithReuseIdentifier: Nib.reuseIdentifier.CCCrowdCell)
    }
    
    @objc private func viewSettings(){
        opensSettings()
    }
}

extension CCCrowdsVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ShowsCardHeader {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: Nib.reuseIdentifier.CCCrowdCell, for: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 11) / 2, height: 200)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CCCrowdHeader", for: indexPath) as? CCCollectionSectionHeader else { return UICollectionReusableView()}
        header.data = viewModel?.titleForSection(section: indexPath.section)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: Constants.CardList.headerHeight)
    }
}
