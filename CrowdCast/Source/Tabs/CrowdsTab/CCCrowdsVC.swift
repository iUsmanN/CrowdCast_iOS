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
    
    var viewMdoel                       : CCCrowdsVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
}

extension CCCrowdsVC : CCSetsNavbar {
    
    private func setupView(){
        setupNavBar(navigationBar   : navigationController?.navigationBar,
                    navigationItem  : navigationItem,
                    title           : "Crowds",
                    largeTitles     : true,
                    profileAction   : #selector(viewSettings))
        collectionView.dataSource   = self
        collectionView.delegate     = self
        collectionView.register(Nib.nibFor(Nib.reuseIdentifier.CCCrowdCell), forCellWithReuseIdentifier: Nib.reuseIdentifier.CCCrowdCell)
    }

    @objc private func viewSettings(){
        opensSettings()
    }
}

extension CCCrowdsVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: Nib.reuseIdentifier.CCCrowdCell, for: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 12) / 2, height: 200)
    }
}
