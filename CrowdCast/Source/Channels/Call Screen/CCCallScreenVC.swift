//
//  CCCallScreenVC.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TwilioVideo

class CCCallScreenVC: CCUIViewController {
    
    var viewModel = CCCallScreenVM()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
        viewModel.room?.disconnect()
    }
}

extension CCCallScreenVC {
    
    func setupView(){
        collectionView.dataSource   = self
        collectionView.delegate     = self
        collectionView.register(UINib(nibName: Nib.reuseIdentifier.CCCallMemberCell, bundle: nil), forCellWithReuseIdentifier: Nib.reuseIdentifier.CCCallMemberCell)
    }
    
    func setupViewModel(channelData: CCChannel?){
        viewModel.SetupVM(inputData: channelData)
    }
    
    func bindVM(){
        viewModel.participantCountPublisher.sink { [weak self] (action, indexes) in
            switch action {
            case .insert:
                self?.insertCells(addedIndexes: indexes)
                //self?.allMetalViews()
            case .remove:
                self?.removeCells()
            }
        }.store(in: &combineCancellable)
    }
}

extension CCCallScreenVC : CCGetIndexPaths {
    
    func allMetalViews(){
        for i in 0..<viewModel.numberOfCells() {
            prints("TAG \(i) : \(self.collectionView.viewWithTag(i))")
            guard let v = self.collectionView.viewWithTag(i) else { return }
            self.collectionView.willRemoveSubview(v)
            self.collectionView.reloadData()
        }
    }
    
    func insertCells(addedIndexes: [Int]){
        self.collectionView.insertItems(at: getIndexPaths(array: addedIndexes))
    }
    
    func removeCells(){
        
    }
}

extension CCCallScreenVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Nib.reuseIdentifier.CCCallMemberCell, for: indexPath) as? CCCallMemberCell else { return UICollectionViewCell() }
        cell.participantData = viewModel.getParticipant(indexPath: indexPath)
        cell.metalTag = indexPath.row
        return cell
    }
}

extension CCCallScreenVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (viewModel.numberOfCells() == 1){
            return CGSize(width: view.frame.size.width, height: view.frame.size.height)
        } else if (viewModel.numberOfCells() == 2){
            return CGSize(width: view.frame.size.width, height: view.frame.size.height/CGFloat(2))
        } else if (viewModel.numberOfCells() == 3) {
            let lowerHeight = view.frame.size.height/(CGFloat(Double(viewModel.numberOfCells())/2).rounded(.up))
            if(indexPath.row == viewModel.numberOfCells() - 1){
                return CGSize(width: view.frame.size.width, height: view.frame.size.height - lowerHeight)
            } else {
                return CGSize(width: view.frame.size.width/2 - 0.5, height: lowerHeight)
            }
        } else if (viewModel.numberOfCells() == 4){
            return CGSize(width: (view.frame.size.width / 2) - 0.5, height: view.frame.size.height / 2)
        } else {
            if(indexPath.row<4){
                return CGSize(width: (view.frame.size.width / 2) - 0.5, height: (view.frame.height) * 1.1/3 )
            } else {
                return CGSize(width: (view.frame.size.width / CGFloat(viewModel.numberOfCells() - 4)) - 0.1, height:  (view.frame.height) * 0.8/3 )
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}

