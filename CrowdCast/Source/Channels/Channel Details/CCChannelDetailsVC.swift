//
//  CCChannelDetailsVC.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TwilioVideo

class CCChannelDetailsVC: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel : CCChannelDetailsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showMe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension CCChannelDetailsVC : CCGetsViewController, CCHapticEngine {
    
    @IBAction func joinCall(_ sender: Any) {
        let viewController = instantiateViewController(storyboard: .Channels, viewController: .CCCallScreenVC, as: CCCallScreenVC())
        viewController.setupViewModel(channelData: viewModel?.data)
        generateHapticFeedback(.light)
        DispatchQueue.main.async {  [weak self] in
            self?.present(viewController, animated: true, completion: nil)
        }
    }
}

extension CCChannelDetailsVC {
    
    func setupViewModel(inputData: CCChannel){
        viewModel = CCChannelDetailsVM(channelData: inputData)
    }
    
    func setupView(){
        navigationItem.title = viewModel?.data.name
    }
}

extension CCChannelDetailsVC : CameraSourceDelegate, VideoViewDelegate {
    
    func showMe(){
        if let camera = CameraSource(delegate: self) {
            viewModel?.localVideoTrack = LocalVideoTrack(source: camera)
            let renderer = VideoView(frame: cameraView.frame)
            renderer.shouldMirror = true
            guard let frontCamera = CameraSource.captureDevice(position: .front) else { return }
            renderer.contentMode = .scaleAspectFill
            camera.startCapture(device: frontCamera)
            viewModel?.localVideoTrack?.addRenderer(renderer)
            self.cameraView.addSubview(renderer)
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.5) {
                    self.cameraViewHeightConstraint.constant = 300
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}
