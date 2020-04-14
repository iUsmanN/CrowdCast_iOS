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
    
    var viewModel : CCChannelDetailsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showMe()
    }
    
}

extension CCChannelDetailsVC : CCGetsViewController {
 
    @IBAction func joinCall(_ sender: Any) {
        let viewController = instantiateViewController(storyboard: .Channels, viewController: .CCCallScreenVC, as: CCCallScreenVC())
        viewController.setupViewModel(channelData: viewModel?.data)
        DispatchQueue.main.async {  [weak self] in self?.navigationController?.pushViewController(viewController, animated: true) }
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
            }
        }
}
