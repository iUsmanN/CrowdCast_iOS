//
//  CCAddChannelVC.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TweeTextField

class CCAddChannelVC: CCUIViewController {
    
    @IBOutlet weak var nameTextField        : TweeActiveTextField!
    @IBOutlet weak var descriptionTextField : TweeActiveTextField!
    @IBOutlet weak var ownerTextField       : TweeBorderedTextField!
    @IBOutlet weak var foreignLinkTextField : TweeActiveTextField!
    @IBOutlet weak var colorCollectionView  : UICollectionView!
    
    var viewModel = CCAddChannelVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func addChannel(_ sender: CCButton) {
        sender.showSpinner()
        pauseScreen()
        viewModel.addChannel(nameInput: nameTextField.text, descriptionInput: descriptionTextField.text, foreignLinkInput: foreignLinkTextField.text) { [weak self] result in
            switch result {
            case .success(let channel):
                DispatchQueue.main.async {
                    guard let parentVC = self?.navigationController?.viewControllers[(self?.navigationController?.viewControllers.count ?? 2) - 2] as? CCChannelActionDelegate else { return }
                    parentVC.channelAdded(data: channel)
                    self?.unpauseScreen()
                    self?.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print(error)
                self?.unpauseScreen()
                sender.hideSpinner()
            }
        }
    }
}

extension CCAddChannelVC {
    
    func setupView(){
        colorCollectionView.dataSource  = self
        colorCollectionView.delegate    = self
        setupNavigationBar()
        ownerTextField.text = viewModel.channelOwner()
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Create Channel"
    }
}

extension CCAddChannelVC : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfColors()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCColorCell", for: indexPath) as? CCColorCell else { return UICollectionViewCell() }
        cell.color = viewModel.colorForItemAt(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedColor = indexPath.row
    }
}
