//
//  MetaDataOutputService.swift
//  SwiftyQR
//
//  Created by Shubham Kamdi on 12/23/22.
//

import Foundation
import AVFoundation
class MetaDataOutputService: NSObject {
    let metadataOutput = AVCaptureMetadataOutput()
    var metaQueue: DispatchQueue?
    var captureSesion: AVCaptureSession?
    init(metaQueue: DispatchQueue?, captureSesion: AVCaptureSession?) {
        self.metaQueue = metaQueue ?? DispatchQueue(label: "SwiftyQR",qos: .background)
        self.captureSesion = captureSesion
    }
    func setupMetaSource() {
        guard let captureSesion = captureSesion,
        let queue = metaQueue else { return }
        if captureSesion.canAddOutput(metadataOutput) {
            metadataOutput.setMetadataObjectsDelegate(self, queue: queue)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .code39, .code128, .qr]
        } else {
            return
        }
    }
}
