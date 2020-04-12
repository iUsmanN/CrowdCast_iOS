//
//  CCCallScreenVM.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import TwilioVideo

class CCCallScreenVM: NSObject {
    
    var room                : Room?
    
    ///Tracks
    var localAudioTrack     = LocalAudioTrack()
    var localDataTrack      = LocalDataTrack()
    var localVideoTrack     : LocalVideoTrack?
    
    var accessToken1 = ""
    
    var accessToken2 = ""
    
    var channelData : CCChannel?
    
    func SetupVM(inputData: CCChannel?){
        channelData = inputData
    }
}

extension CCCallScreenVM {
    
    func numberOfCells() -> Int {
        3
    }
}


extension CCCallScreenVM {
    
    func joinChannel(identity: String?, channelID: String?, result: ((Result<Room, CCError>)->())?){
        guard let identity = identity, let channelID = channelID else { result?(.failure(.twilioCredentialsError)); return }
        
        let connectOptions = ConnectOptions(token: accessToken1) { (connectOptionsBuilder) in
            connectOptionsBuilder.roomName = channelID
            if let audioTrack = self.localAudioTrack {
                connectOptionsBuilder.audioTracks   = [ audioTrack ]
            }
            if let dataTrack = self.localDataTrack {
                connectOptionsBuilder.dataTracks    = [ dataTrack ]
            }
            if let videoTrack = self.localVideoTrack {
                connectOptionsBuilder.videoTracks   = [ videoTrack ]
            }
        }
        room = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
    }
}

extension CCCallScreenVM : RoomDelegate {
    
    func roomDidConnect(room: Room) {
        print("roomDidConnect")
        
        if let localParticipant = room.localParticipant {
            print("Local identity \(localParticipant.identity)")
        }
        
        // Connected participants
        let participants = room.remoteParticipants;
        print("Number of connected Participants \(participants.count)")
        
    }
    
    func roomDidFailToConnect(room: Room, error: Error) {
        print("roomDidFailToConnect -> \(error)")
    }
    
    func roomIsReconnecting(room: Room, error: Error) {
        print("roomIsReconnecting")
    }
    
    func participantDidConnect(room: Room, participant: RemoteParticipant) {
        print("participantDidConnect")
        participant.delegate = self
    }
    
    func participantDidDisconnect(room: Room, participant: RemoteParticipant) {
        print("participantDidDisconnect")
    }
    
    func dominantSpeakerDidChange(room: Room, participant: RemoteParticipant?) {
        print("dominantSpeakerDidChange")
    }
}

extension CCCallScreenVM : CameraSourceDelegate, RemoteParticipantDelegate {
    
    func didSubscribeToVideoTrack(videoTrack: RemoteVideoTrack,
                                  publication: RemoteVideoTrackPublication,
                                  participant: RemoteParticipant) {
        
        print("Participant \(participant.identity) added a video track.")
        
//        if let remoteView = VideoView.init(frame: self.view.bounds, delegate:self) {
//
//            videoTrack.addRenderer(remoteView)
//            self.view.addSubview(remoteView)
//            self.remoteView = remoteView
//        }
    }
}

extension CCCallScreenVM: VideoViewDelegate {
    
    func showMe(){
        if let camera = CameraSource(delegate: self) {
            localVideoTrack = LocalVideoTrack(source: camera)
            
//            // VideoView is a VideoRenderer and can be added to any VideoTrack.
//            let renderer = VideoView(frame: myview.bounds)
//
//            guard let frontCamera = CameraSource.captureDevice(position: .front) else {
//                // The device does not have a front camera.
//                return
//            }
//
//            // Start capturing with the device that we discovered.
//            camera.startCapture(device: frontCamera)
//
//            localVideoTrack?.addRenderer(renderer)
//            self.view.addSubview(renderer)
        }
    }
}
