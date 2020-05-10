//
//  CCCameraView.swift
//  CrowdCast
//
//  Created by Usman on 10/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CCCameraView          : UIView {
    
    var captureSession                  = AVCaptureSession()
    var videoPreviewLayer               : AVCaptureVideoPreviewLayer?
    var capturePhotoOutput              = AVCapturePhotoOutput()
    
    func startCapture() {
        initUI(.front)
    }
    
    func initUI(_ position: AVCaptureDevice.Position) {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) { captureSession.addInput(input) }
            DispatchQueue.main.async { [weak self] in
                self?.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self!.captureSession)
                self?.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self?.videoPreviewLayer?.frame = self!.frame
                self?.layer.addSublayer(self!.videoPreviewLayer!)
                self?.captureSession.commitConfiguration()
                self?.captureSession.startRunning()
            }
        } catch {
            print("Error")
        }
    }
}
