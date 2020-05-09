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

enum dataAction {
    case insert
    case remove
}

typealias callParticipantData = (Participant, VideoTrack?)

class CCCallScreenVM: NSObject {
    
    var participantCountPublisher   = PassthroughSubject<(dataAction, [Int]), Never>()
    var callParticipants            : [callParticipantData]? = [callParticipantData]()
    var room                        : Room?
    
    ///Tracks
    var localAudioTrack     = LocalAudioTrack()
    var localDataTrack      = LocalDataTrack()
    var localVideoTrack     : LocalVideoTrack?
    
    //t1
    var accessToken1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODg5NzIzMTIiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4ODk3NTkxMiwiZ3JhbnRzIjp7ImlkZW50aXR5IjoidXNtYW4iLCJ2aWRlbyI6e319fQ.KZ18p-84vpEqyL4d2kcTqwzkUnGKEBQZGwkBGblIq5k"
    
    //t2
    var accessToken2 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODg5NzIzMzkiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4ODk3NTkzOSwiZ3JhbnRzIjp7ImlkZW50aXR5IjoibWFtYSIsInZpZGVvIjp7fX19.walEt6U7dKhrYYvS2NnOkQCSD0HvV2hjWa2N7FyyTio"
    
    //ahmer
    var accessToken3 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODcwNTY1NDgiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4NzA2MDE0OCwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiYyIsInZpZGVvIjp7fX19.5ffaJ-obovVk6mHs_r5WlyW3lN1EuwgX3zkqTMpgU2w"
    
    var channelData : CCChannel?
    
    func SetupVM(inputData: CCChannel?){
        channelData = inputData
        setupLocalVideoTrack()
        joinChannel(result: nil)
    }
}

extension CCCallScreenVM {
    
    func numberOfCells() -> Int {
        return callParticipants?.count ?? 0
    }
    
    func getParticipant(indexPath: IndexPath) -> callParticipantData? {
        return callParticipants?[indexPath.row]
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
        for i in 0..<room.remoteParticipants.count { room.remoteParticipants[i].delegate = self }
        guard let localParticipant          = room.localParticipant.map({ (participant) -> callParticipantData in
            return (participant, localVideoTrack)
        }) else { return }
        callParticipants?.append(localParticipant)
        participantCountPublisher.send((.insert, [0]))
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
        guard let index = callParticipants?.firstIndex(where: { (participantData) -> Bool in
            participantData.0.identity == participant.identity
        }) else { return }
        callParticipants?.remove(at: index)
        participantCountPublisher.send((.remove, [index]))
    }
    
    func dominantSpeakerDidChange(room: Room, participant: RemoteParticipant?) {
        print("dominantSpeakerDidChange")
    }
}

extension CCCallScreenVM : RemoteParticipantDelegate {
    func didSubscribeToVideoTrack(videoTrack: RemoteVideoTrack, publication: RemoteVideoTrackPublication, participant: RemoteParticipant) {
        print("A")
        callParticipants?.insert((participant, videoTrack), at: 0)
        participantCountPublisher.send((.insert, [(callParticipants?.count ?? 2) - 2]))
        
    }
    
    func didFailToSubscribeToVideoTrack(publication: RemoteVideoTrackPublication, error: Error, participant: RemoteParticipant) {
        print("B")
        callParticipants?.insert((participant, nil), at: 0)
        participantCountPublisher.send((.insert, [(callParticipants?.count ?? 2) - 2]))
    }
}

extension CCCallScreenVM : CameraSourceDelegate {
    
    func setupLocalVideoTrack(){
        if let camera = CameraSource(delegate: self) {
            localVideoTrack = LocalVideoTrack(source: camera)
            guard let frontCamera = CameraSource.captureDevice(position: .front) else { return }
            camera.startCapture(device: frontCamera)
        }
    }
}
