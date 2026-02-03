//
//  SimpleCameraManager.swift
//  PinjamCepat
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
            title: LanguageManager.shared.getLanguage() == "701" ? "Izin Kamera" : "Camera Permission",
            message: LanguageManager.shared.getLanguage() == "701" ? "Izin kamera belum diaktifkan, sehingga Anda tidak dapat mengambil foto kartu identitas! Silakan berikan otorisasi izin di Pengaturan terlebih dahulu, kemudian Anda dapat melanjutkan pengajuan Anda." : "Camera permission is not enabled, so you cannot take photos of your ID card! Authorize the permission in Settings first, and then you can continue with your application.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: LanguageManager.shared.getLanguage() == "701" ? "Membatalkan" : "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: LanguageManager.shared.getLanguage() == "701" ? "Pengaturan" : "Settings", style: .default) { _ in
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
