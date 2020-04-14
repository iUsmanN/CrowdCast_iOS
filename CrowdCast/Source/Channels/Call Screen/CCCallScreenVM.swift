//
//  CCCallScreenVM.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Combine
import TwilioVideo

class CCCallScreenVM: NSObject {

    var participantCountPublisher = PassthroughSubject<Int, Never>()
    
    var participantCount : Int? = 0 {
        didSet {
            participantCountPublisher.send(participantCount ?? 1)
        }
    }
    
    var room                : Room?

    ///Tracks
    var localAudioTrack     = LocalAudioTrack()
    var localDataTrack      = LocalDataTrack()
    var localVideoTrack     : LocalVideoTrack?
    
    //t1
    var accessToken1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODY4Njk2MzEiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4Njg3MzIzMSwiZ3JhbnRzIjp7ImlkZW50aXR5IjoidDEiLCJ2aWRlbyI6e319fQ.IbtcKP-kvvNxZpMsRz3rNv7PvlusqE8VAc_mtjzw420"
    
    //t2
    var accessToken2 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODY4Njk2NTUiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4Njg3MzI1NSwiZ3JhbnRzIjp7ImlkZW50aXR5IjoidDIiLCJ2aWRlbyI6e319fQ.5TUhFGUaXWXBE56Li5BegwmlkkZNmEg6MeJ4ZrCm57g"
    
    //ahmer
    var accessToken3 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODY4NzA1MjAiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4Njg3NDEyMCwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiYWhtZXIiLCJ2aWRlbyI6e319fQ.Cwibe2XVC5_Ywe25gDF5YEiakhhSykke97yH6kP5WTs"
    
    var channelData : CCChannel?
    
    func SetupVM(inputData: CCChannel?){
        channelData = inputData
        joinChannel(result: nil)
    }
}

extension CCCallScreenVM {
    
    func numberOfCells() -> Int {
        return participantCount ?? 0
    }
}


extension CCCallScreenVM {
    
    func joinChannel(result: ((Result<Room, CCError>)->())?){
        guard let channelID = channelData?.id else { result?(.failure(.twilioCredentialsError)); return }
        
        let connectOptions = ConnectOptions(token: accessToken3) { (connectOptionsBuilder) in
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
        participantCount = participants.count + 1
        
    }
    
    func roomDidFailToConnect(room: Room, error: Error) {
        print("roomDidFailToConnect -> \(error)")
    }
    
    func roomIsReconnecting(room: Room, error: Error) {
        print("roomIsReconnecting")
    }
    
    func participantDidConnect(room: Room, participant: RemoteParticipant) {
        print("participantDidConnect")
        participantCount = (participantCount ?? 1) + 1
        participant.delegate = self
    }
    
    func participantDidDisconnect(room: Room, participant: RemoteParticipant) {
        print("participantDidDisconnect")
        participantCount = (participantCount ?? 1) - 1
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
