//
//  CCCallMemberCell.swift
//  CrowdCast
//
//  Created by Usman on 16/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Combine
import TwilioVideo

class CCCallMemberCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var remoteVideo : VideoView?
    var localVideoTrack : LocalVideoTrack?
    var participantData: callParticipantData? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        prints("Setup Call Cell View")
        nameLabel.text = participantData?.0.identity
        if (participantData?.0 is LocalParticipant){
            nameLabel.text = "Local"
        }
        setVideo(data: participantData?.1)
    }
    
    func setVideo(data: RemoteVideoTrack?) {
        
        switch participantData?.0 {
        case is LocalParticipant:
            prints("local")
            if let camera = CameraSource(delegate: self) {
                localVideoTrack = LocalVideoTrack(source: camera)
                let renderer = VideoView(frame: backView.frame)
                renderer.shouldMirror = true
                guard let frontCamera = CameraSource.captureDevice(position: .front) else { return }
                renderer.contentMode = .scaleAspectFill
                camera.startCapture(device: frontCamera)
                localVideoTrack?.addRenderer(renderer)
                self.backView.addSubview(renderer)
            }
        default:
            if let participantVideo = VideoView(frame: backView.frame, delegate: self, renderingType: .metal) {
                data?.addRenderer(participantVideo)
                participantVideo.contentMode = .scaleAspectFill
                self.backView.addSubview(participantVideo)
                self.remoteVideo = participantVideo
            }
        }
    }
}

extension CCCallMemberCell : VideoViewDelegate, CameraSourceDelegate {
    
}
