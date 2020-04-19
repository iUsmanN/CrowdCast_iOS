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
    
    @IBOutlet weak var backView         : UIView!
    @IBOutlet weak var avatarImageView  : UIImageView!
    @IBOutlet weak var nameLabel        : UILabel!
    
    var remoteVideo         : VideoView?
    var localVideoTrack     : LocalVideoTrack?
    var metalTag            : Int?
    var participantData     : callParticipantData? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        nameLabel.text = participantData?.0.identity
        if (participantData?.0 is LocalParticipant){ nameLabel.text = "Local" }
        setVideo(data: participantData?.1)
    }
}

extension CCCallMemberCell : VideoViewDelegate, CameraSourceDelegate {
    func setVideo(data: VideoTrack?) {
        guard let data = data else { return }
        if let participantVideo = VideoView(frame: backView.frame, delegate: self, renderingType: .metal) {
            data.addRenderer(participantVideo)
            participantVideo.contentMode = .scaleAspectFill
            participantVideo.tag = 99
            self.backView.addSubview(participantVideo)
            self.remoteVideo = participantVideo
        }
    }
}
