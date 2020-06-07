//
//  CCJoinChannelVC.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Kingfisher

class CCJoinChannelVC: UIViewController {
 
    @IBOutlet weak var joinBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileView              : UIImageView!
    @IBOutlet weak var cameraView               : CCCameraView!
    @IBOutlet weak var gradientView             : UIImageView!
    
    @IBOutlet weak var cameraButton             : CCButton!
    @IBOutlet weak var micButton                : CCButton!
    @IBOutlet weak var foreignJoinButton        : CCButton!
    
    var viewModel                               : CCJoinChannelVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "Inverted")
        navigationItem.title = viewModel?.channelName() ?? ""
        toggleCameraView(enable: getCallToggles().0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        toggleCameraView(enable: false)
    }
    
}

extension CCJoinChannelVC : CCGetsViewController, CCHapticEngine {
    
    @IBAction func joinCall(_ sender: Any) {
        let viewController = instantiateViewController(storyboard: .Channels, viewController: .CCCallScreenVC, as: CCCallScreenVC())
        viewController.setupViewModel(channelData: viewModel?.getData())
        generateHapticFeedback(.light)
        DispatchQueue.main.async {  [weak self] in self?.present(viewController, animated: true, completion: nil) }
    }
    
    @IBAction func channelDetailsPressed(_ sender: Any) {
        let vc = instantiateViewController(storyboard: .Channels, viewController: .CCChannelDetailsVC, as: CCChannelDetailsVC())
        vc.setupViewModel(inputData: viewModel?.getData())
        generateHapticFeedback(.light)
        DispatchQueue.main.async { self.navigationController?.pushViewController(vc, animated: true) }
    }
    
    @IBAction func cameraToggle(_ sender: Any) {
        toggleCallVideo()
        toggleVideoButton(enable: getCallToggles().0)
        toggleCameraView(enable: getCallToggles().0)
    }
    
    @IBAction func micToggle(_ sender: Any) {
        toggleCallAudio()
        toggleAudioButton(enable: getCallToggles().1)
    }
    
    @IBAction func openForeignLink(_ sender: Any) {
        guard let url = viewModel?.foreignURL() else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension CCJoinChannelVC : CCImageStorage {
    
    func setupView(){
        guard let url = imageCacheURL(id: CCProfileManager.sharedInstance.getUID()) else { return }
        profileView.kf.setImage(with: ImageResource(downloadURL: url))
        setupLayers()
        toggleVideoButton(enable: getCallToggles().0)
        toggleAudioButton(enable: getCallToggles().1)
        cameraView.setupCameraView()
        setupNavigationBar()
        toggleForeignJoinView(enable: viewModel?.containsForeignLink ?? false)
    }
    
    func toggleForeignJoinView(enable: Bool){
        if enable {
            foreignJoinButton.setTitle(viewModel?.foreignLinkText(), for: .normal)
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut, animations: { [weak self] in
                self?.joinBottomConstraint.constant = 70
                //self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func toggleCameraView(enable: Bool){
        if enable {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
                UIView.animate(withDuration: 0.5) { self.cameraView.alpha = 1 }
            }
            cameraView.startCapture()
        } else {
            cameraView.alpha = 0
            cameraView.stopCapture()
        }
    }
    
    
    func setupLayers() {
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
    }
    
    func setupViewModel(inputData: CCChannel){
        viewModel = CCJoinChannelVM(channel: inputData)
    }
    
    func setupNavigationBar(){
        navigationItem.title = viewModel?.channelName() ?? ""
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .clear
        gradientView.image = UIImage(named: "BW Gradient")?.withRenderingMode(.alwaysTemplate)
    }
}

extension CCJoinChannelVC: CCUniversalCallToggle {
    
    func toggleVideoButton(enable: Bool){
        cameraButton.setImage(enable ? UIImage(systemName: "video.fill") : UIImage(systemName: "video.slash.fill"), for: .normal)
        enable ? cameraButton.greenBorder() : cameraButton.redBorder()
    }
    
    func toggleAudioButton(enable: Bool){
        micButton.setImage(enable ? UIImage(systemName: "mic.fill") : UIImage(systemName: "mic.slash.fill"), for: .normal)
        enable ? micButton.greenBorder() : micButton.redBorder()
    }
}
