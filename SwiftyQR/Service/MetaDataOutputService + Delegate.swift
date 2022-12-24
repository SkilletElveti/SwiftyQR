//
//  MetaDataOutput _ Delegate.swift
//  SwiftyQR
//
//  Created by Shubham Kamdi on 12/23/22.
//

import Foundation
import AVFoundation

extension MetaDataOutputService: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSesion?.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            print("Data: \(stringValue)")
        }
    }
}
