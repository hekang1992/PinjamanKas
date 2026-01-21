//
//  SimpleCameraManager.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
internal import AVFoundation

final class SimpleCameraManager: NSObject {
    
    // MARK: - Public
    enum CameraPosition {
        case front
        case back
    }
    
    typealias CaptureCompletion = (Data) -> Void
    
    // MARK: - Private
    private weak var presentingVC: UIViewController?
    private var completion: CaptureCompletion?
    private var cameraPosition: CameraPosition = .back
    
    // MARK: - Init
    init(presentingVC: UIViewController) {
        self.presentingVC = presentingVC
    }
    
    // MARK: - Public Method
    func takePhoto(position: CameraPosition,
                   completion: @escaping CaptureCompletion) {
        
        self.cameraPosition = position
        self.completion = completion
        checkCameraPermission()
    }
}

private extension SimpleCameraManager {
    
    func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            presentCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    granted ? self.presentCamera() : self.showPermissionAlert()
                }
            }
        default:
            showPermissionAlert()
        }
    }
    
    func showPermissionAlert() {
        guard let vc = presentingVC else { return }
        
        let alert = UIAlertController(
            title: "无法使用相机",
            message: "请在设置中开启相机权限",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        vc.present(alert, animated: true)
    }
}

private extension SimpleCameraManager {
    
    func presentCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera),
              let vc = presentingVC else { return }
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = false
        
        if #available(iOS 13.0, *) {
            picker.cameraDevice = cameraPosition == .front ? .front : .rear
        }
        
        vc.present(picker, animated: true)
    }
}

extension SimpleCameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage,
              let data = compress(image: image, maxKB: 800) else {
            return
        }
        
        completion?(data)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

private extension SimpleCameraManager {
    
    func compress(image: UIImage, maxKB: Int) -> Data? {
        let maxBytes = maxKB * 1024
        var quality: CGFloat = 0.5
        var data = image.jpegData(compressionQuality: quality)
        
        while let d = data, d.count > maxBytes, quality > 0.1 {
            quality -= 0.05
            data = image.jpegData(compressionQuality: quality)
        }
        return data
    }
}
