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
    
    @IBOutlet weak var profileView  : UIImageView!
    @IBOutlet weak var cameraView   : CCCameraView!
    @IBOutlet weak var gradientView : UIImageView!
    
    @IBOutlet weak var cameraButton : CCButton!
    @IBOutlet weak var micButton    : CCButton!
    
    var viewModel : CCJoinChannelVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "Inverted")
        toggleCameraView(enable: true)
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
        let vc = instantiateViewController(storyboard: .Channels, viewController: .ChannelDetails, as: CCChannelDetailsVC())
        vc.setupViewModel(inputData: viewModel?.getData())
        generateHapticFeedback(.light)
        DispatchQueue.main.async { self.navigationController?.pushViewController(vc, animated: true) }
    }
    
    @IBAction func cameraToggle(_ sender: Any) {
        let cameraOn = !(viewModel?.cameraOn ?? false)
        viewModel?.cameraOn = cameraOn
        cameraButton.setImage(cameraOn ? UIImage(systemName: "video.fill") : UIImage(systemName: "video.slash.fill"), for: .normal)
        cameraOn ? cameraButton.greenBorder() : cameraButton.redBorder()
        toggleCameraView(enable: cameraOn)
    }
    
    @IBAction func micToggle(_ sender: Any) {
        let micOn = !(viewModel?.micOn ?? false)
        viewModel?.micOn = micOn
        micButton.setImage(micOn ? UIImage(systemName: "mic.fill") : UIImage(systemName: "mic.slash.fill"), for: .normal)
        micOn ? micButton.greenBorder() : micButton.redBorder()
    }
}

extension CCJoinChannelVC : CCImageStorage {
    
    func setupView(){
        guard let url = imageCacheURL(id: CCProfileManager.sharedInstance.getUID()) else { return }
        profileView.kf.setImage(with: ImageResource(downloadURL: url))
        setupLayers()
        cameraView.setupCameraView()
        setupNavigationBar()
    }
    
    func toggleCameraView(enable: Bool){
        if enable {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
                UIView.animate(withDuration: 0.5) {
                    self.cameraView.alpha = 1
                }
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
