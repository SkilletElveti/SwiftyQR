//
//  CameraService.swift
//  SwiftyQR
//
//  Created by Shubham Kamdi on 12/23/22.
//

import Foundation
import AVFoundation
import UIKit
class CameraService: NSObject {
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var queue: DispatchQueue?
    var view: UIView?
    func setupCamera() {
        queue?.async {
            [weak self] in
            guard let self = self else { return }
            self.captureSession?.stopRunning()
            self.captureSession = AVCaptureSession()
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }
            
            if (self.captureSession?.canAddInput(videoInput) ?? false) {
                self.captureSession?.addInput(videoInput)
            } else {
                
            }
            let metadataService = MetaDataOutputService(metaQueue: self.queue, captureSesion: self.captureSession)
            metadataService.setupMetaSource()
        }
        guard let captureSession = captureSession,
              let view = view else { return }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
                
    }
}
