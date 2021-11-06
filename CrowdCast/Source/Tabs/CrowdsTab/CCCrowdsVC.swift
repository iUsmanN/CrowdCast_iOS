//
//  CCCrowdsVC.swift
//  CrowdCast
//
//  Created by Usman on 30/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Combine
import Kingfisher

class CCCrowdsVC: CCUIViewController {
    
    @IBOutlet weak var collectionView   : UICollectionView!
    
    var viewModel                       : CCCrowdsVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupVM()
        bindVM()
    }
}

extension CCCrowdsVC {
    
    func bindVM(){
        viewModel?.crowdsPublisher.sink(receiveValue: { [weak self] (indexPathsInput) in
            switch indexPathsInput.0 {
            case .insert:
                self?.insertRows(at: indexPathsInput.1)
            case .remove:
                self?.removeRows(at: indexPathsInput.1)
            default:
                prints("Refresh Rows")
            }}).store(in: &combineCancellable)
    }
    
    func insertRows(at indexPaths: [IndexPath]) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadSections(IndexSet(arrayLiteral: 0))
        }
    }
    
    func removeRows(at indexPath: [IndexPath]) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadSections(IndexSet(arrayLiteral: 1))
        }
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

extension CCCrowdsVC : UICollectionViewDataSource, UICollectionViewDelegate, CCGetsViewController, UICollectionViewDelegateFlowLayout, ShowsCardHeader {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Nib.reuseIdentifier.CCCrowdCell, for: indexPath) as? CCCrowdCell else { return UICollectionViewCell() }
        cell.cardImage.kf.cancelDownloadTask()
        cell.data = viewModel?.dataForItem(indexPath: indexPath)
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width-15)/2, height: 165)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CCCrowdHeader", for: indexPath) as? CCCollectionSectionHeader else { return UICollectionReusableView()}
            header.data = viewModel?.titleForSection(section: indexPath.section)
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CCEmptyCollectionSection", for: indexPath)
            
            return footerView
            
        default:
            assert(false, "Unexpected element kind")
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: Constants.CardList.headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return (viewModel?.numberOfRows(section: section) ?? 0) > 0 ? CGSize.zero : CGSize(width: self.collectionView.frame.size.width, height: Constants.CrowdList.headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = instantiateViewController(storyboard: .Groups, viewController: .CCCrowdChannelsVC, as: CCCrowdChannelsVC())
        viewController.setupViewModel(crowdData: viewModel?.dataForItem(indexPath: indexPath))
        DispatchQueue.main.async {[weak self] in self?.navigationController?.pushViewController(viewController, animated: true) }
    }
}
