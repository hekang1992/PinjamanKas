//
//  LoginViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire
import FBSDKCoreKit
import AppTrackingTransparency

class LoginViewController: BaseViewController {
    
    private var countdownTimer: Timer?
    
    private var remainingSeconds = 60
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: .zero)
        return loginView
    }()
    
    private let locationManager = LocationManager()
    
    var brute: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        setupButtonActions()
        
        brute = String(Int(Date().timeIntervalSince1970))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.phoneFiled.becomeFirstResponder()
        Task {
            await self.getIDFA()
        }
    }
    
    @MainActor
    deinit {
        stopCountdown()
        print("❎ LoginViewController=======")
    }
    
}

extension LoginViewController {
    
    private func setupButtonActions() {
        loginView.codeBtn.addTarget(self, action: #selector(getVerificationCode), for: .touchUpInside)
        loginView.loginBtn.addTarget(self, action: #selector(getLogin), for: .touchUpInside)
    }
    
    @objc func getVerificationCode() {
        brute = String(Int(Date().timeIntervalSince1970))
        guard let phone = loginView.phoneFiled.text, !phone.isEmpty else {
            ToastManager.showMessage(languageCode == "701" ? "Silakan masukkan nomor ponsel yang benar." : "Please enter the correct mobile phone number.")
            return
        }
        Task {
            await self.codeInfo(with: phone)
        }
    }
    
    @objc func getLogin() {
        self.loginView.phoneFiled.resignFirstResponder()
        self.loginView.codeFiled.resignFirstResponder()
        guard let phone = loginView.phoneFiled.text, !phone.isEmpty else {
            ToastManager.showMessage(languageCode == "701" ? "Silakan masukkan nomor ponsel yang benar." : "Please enter the correct mobile phone number.")
            return
        }
        
        guard let code = loginView.codeFiled.text, !code.isEmpty else {
            ToastManager.showMessage(languageCode == "701" ? "Silakan masukkan kode verifikasi yang benar." : "Please enter the correct verification code.")
            return
        }
        
        if loginView.sureBtn.isSelected == false {
            ToastManager.showMessage(languageCode == "701" ? "Harap baca dan konfirmasi perjanjian masuk sebelum melakukan login." : "Please read and confirm the login agreement before logging in.")
            return
        }
        Task {
            await self.loginInfo(with: phone, code: code)
            if UserManager.shared.isLogin {
                let params = ["bladder": "",
                              "hinted": "1",
                              "shipment": "",
                              "brute": brute,
                              "brawny": String(Int(Date().timeIntervalSince1970))]
                await self.softlySmallInfo(with: params)
            }
        }
    }
    
    private func codeInfo(with phone: String) async {
        do {
            LoadingView.shared.show()
            let params = ["bulging": phone]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/woodwork/italian/businessman", method: .post, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                startCountdown()
            }
            ToastManager.showMessage(model.strangler ?? "")
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    private func loginInfo(with phone: String, code: String) async {
        do {
            LoadingView.shared.show()
            let params = ["waste": phone, "sphincter": code]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/nothing/friend/guinea", method: .post, params: params)
            let sinking = model.sinking ?? ""
            ToastManager.showMessage(model.strangler ?? "")
            if ["0", "00"].contains(sinking) {
                let phone = model.sagged?.waste ?? ""
                let token = model.sagged?.speculatively ?? ""
                UserManager.shared.saveLoginInfo(phone: phone, token: token)
                try? await Task.sleep(nanoseconds: 500_000_000)
                NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
}

extension LoginViewController {
    
    private func startCountdown() {
        loginView.codeBtn.isEnabled = false
        remainingSeconds = 60
        
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateCountdown),
            userInfo: nil,
            repeats: true
        )
        
        RunLoop.current.add(countdownTimer!, forMode: .common)
        
    }
    
    @objc private func updateCountdown() {
        remainingSeconds -= 1
        
        if remainingSeconds <= 0 {
            stopCountdown()
            resetButton()
        } else {
            updateCountdownButton()
        }
    }
    
    private func updateCountdownButton() {
        let title = "\(remainingSeconds)s"
        
        DispatchQueue.main.async {
            self.loginView.codeBtn.setTitle(title, for: .disabled)
        }
    }
    
    private func resetButton() {
        DispatchQueue.main.async {
            self.loginView.codeBtn.isEnabled = true
            self.loginView.codeBtn.setTitle(self.languageCode == "701" ? "Dapatkan kode" : "Get code", for: .normal)
        }
    }
    
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
}

extension LoginViewController {
    
    private func getIDFA() async {
        guard #available(iOS 14, *) else { return }
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let status = await ATTrackingManager.requestTrackingAuthorization()
        
        switch status {
        case .authorized, .denied, .notDetermined:
            Task {
                await self.uploadIDFA()
            }
            
        case .restricted:
            break
            
        @unknown default:
            break
        }
    }
    
    private func uploadIDFA() async {
        let idfa = KeychainHelper.shared.getIDFA()
        let idfv = KeychainHelper.shared.getDeviceIDFV()
        let params = ["controlling": idfv, "africa": idfa]
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/softly/contrition/witnesses/hospital", method: .post, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                if let fcModel = model.sagged?.facebook {
                    fcInfo(with: fcModel)
                }
            }
        } catch {
            
        }
    }
    
    private func fcInfo(with model: facebookModel) {
        Settings.shared.displayName = model.displayName ?? ""
        Settings.shared.appURLSchemeSuffix = model.appURLSchemeSuffix ?? ""
        Settings.shared.appID = model.appID ?? ""
        Settings.shared.clientToken = model.clientToken ?? ""
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
    }
    
}
