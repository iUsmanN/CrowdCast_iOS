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
    
    var callParticipants : [Participant]? = [Participant]() {
        didSet {
            participantCountPublisher.send(callParticipants?.count ?? 0)
        }
    }
    
    var room                : Room?

    ///Tracks
    var localAudioTrack     = LocalAudioTrack()
    var localDataTrack      = LocalDataTrack()
    var localVideoTrack     : LocalVideoTrack?
    
    //t1
    var accessToken1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODY4ODcwNjgiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4Njg5MDY2OCwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiYWJjIiwidmlkZW8iOnt9fX0.UvNOZIly8vcWbYHXwKenoAKmFUuGUoh3_1UgzVZnn4M"
    
    //t2
    var accessToken2 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODY4ODgxOTkiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4Njg5MTc5OSwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiYWJjZCIsInZpZGVvIjp7fX19.PRa9KspIrikE3tZq8ikQmB7hvzlhuVA_q9nOJOA1CLg"
    
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
        return callParticipants?.count ?? 0//participantCount ?? 0
    }
}


extension CCCallScreenVM {
    
    func joinChannel(result: ((Result<Room, CCError>)->())?){
        guard let channelID = channelData?.id else { result?(.failure(.twilioCredentialsError)); return }
        
        let connectOptions = ConnectOptions(token: accessToken2) { (connectOptionsBuilder) in
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
        
        guard let localParticipant          = room.localParticipant else { return }
        let remoteParticipants              = room.remoteParticipants
        var AllParticipants : [Participant] = remoteParticipants
        AllParticipants.append(localParticipant)
        callParticipants                    = AllParticipants
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
        callParticipants?.insert(participant, at: 0)
    }
    
    func participantDidDisconnect(room: Room, participant: RemoteParticipant) {
        print("participantDidDisconnect")
        //participantCount = (participantCount ?? 1) - 1
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
