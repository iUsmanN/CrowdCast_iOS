//
//  CCCallMemberCell.swift
//  CrowdCast
//
//  Created by Usman on 16/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TwilioVideo

class CCCallMemberCell: UICollectionViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var remoteVideo : VideoView?
    
    var participantData: callParticipantData? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        prints("Setup Call Cell View")
        nameLabel.text = participantData?.0.identity
        setVideo(data: participantData?.1)
    }
    
    func setVideo(data: RemoteVideoTrack?) {
        
        if let participantVideo = VideoView(frame: backView.frame, delegate: self, renderingType: .metal) {
            data?.addRenderer(participantVideo)
            participantVideo.contentMode = .scaleAspectFill
            self.backView.addSubview(participantVideo)
            self.remoteVideo = participantVideo
        }
    }
}

extension CCCallMemberCell : VideoViewDelegate {
    
}
