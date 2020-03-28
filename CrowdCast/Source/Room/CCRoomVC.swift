//
//  CCRoomVC.swift
//  CrowdCast
//
//  Created by Usman on 28/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import TwilioVideo

class CCRoomVC: UIViewController {
    
    var room : Room?
    var remoteView : VideoView?
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var otherview: UIView!
    
    // Create an audio track
    var localAudioTrack = LocalAudioTrack()
    
    // Create a data track
    var localDataTrack = LocalDataTrack()
    
    // Create a CameraSource to provide content for the video track
    var localVideoTrack : LocalVideoTrack?
    
    
    var twilioAccessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODUzOTY3MjUiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4NTQwMDMyNSwiZ3JhbnRzIjp7ImlkZW50aXR5IjoidGVzdDEiLCJ2aWRlbyI6e319fQ.YKm64DXEDLk4KUyYtxC-abxMRc7qmsaIFeFXx8SiAEg"
    
    var twilioAccessToken2 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlLTE1ODUzOTk1OTYiLCJpc3MiOiJTSzcwNmE1YjVmMmM2NTlhYzA5ZWZhMmM1N2QyMTI1NTRlIiwic3ViIjoiQUM4OTRhZWJhMTZkZjllY2Q4OGYyMzg4NDg0MWU0NTk2ZCIsImV4cCI6MTU4NTQwMzE5NiwiZ3JhbnRzIjp7ImlkZW50aXR5IjoidGVzdDIiLCJ2aWRlbyI6e319fQ.QS6c6v8eY32cZNVDZq_wHMhDWSUX-D9bmNejjhSTEkk"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func joinRoomPressed(_ sender: Any) {
        showMe()
    }
    
    @IBAction func createRoomPressed(_ sender: Any) {
        createARoom()
    }
    
}

extension CCRoomVC {
    
    func createARoom() {
        let connectOptions = ConnectOptions(token: twilioAccessToken2) { (builder) in
            builder.roomName = "my-room"
            
            if let audioTrack = self.localAudioTrack {
                builder.audioTracks = [ audioTrack ]
            }
            if let dataTrack = self.localDataTrack {
                builder.dataTracks = [ dataTrack ]
            }
            if let videoTrack = self.localVideoTrack {
                builder.videoTracks = [ videoTrack ]
            }
        }
        room = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
    }
    
}

extension CCRoomVC : RoomDelegate {
    
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
        print("roomDidFailToConnect")
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

extension CCRoomVC : CameraSourceDelegate, RemoteParticipantDelegate {
    
    func didSubscribeToVideoTrack(videoTrack: RemoteVideoTrack,
                                  publication: RemoteVideoTrackPublication,
                                  participant: RemoteParticipant) {
        
        print("Participant \(participant.identity) added a video track.")
        
        if let remoteView = VideoView.init(frame: self.otherview.bounds,
                                           delegate:self) {
            
            videoTrack.addRenderer(remoteView)
            self.view.addSubview(remoteView)
            self.remoteView = remoteView
        }
    }
    
}

extension CCRoomVC: VideoViewDelegate {
    
    func showMe(){
        if let camera = CameraSource(delegate: self) {
            localVideoTrack = LocalVideoTrack(source: camera)
            
            // VideoView is a VideoRenderer and can be added to any VideoTrack.
            let renderer = VideoView(frame: myview.bounds)
            
            guard let frontCamera = CameraSource.captureDevice(position: .front) else {
                // The device does not have a front camera.
                return
            }
            
            // Start capturing with the device that we discovered.
            camera.startCapture(device: frontCamera)
            
            localVideoTrack?.addRenderer(renderer)
            self.view.addSubview(renderer)
        }
    }
}
