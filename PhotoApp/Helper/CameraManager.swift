//
//  CameraManager.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 23.03.22.
//

import Foundation
import AVFoundation

class CameraManager : ObservableObject {
    @Published var permissionGranted = false
    
    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            DispatchQueue.main.async {
                self.permissionGranted = accessGranted
            }
        })
    }
}
