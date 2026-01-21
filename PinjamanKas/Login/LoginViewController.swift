//
//  LoginViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire

class LoginViewController: BaseViewController {
    
    private var countdownTimer: Timer?
    
    private var remainingSeconds = 60
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: .zero)
        return loginView
    }()
    
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.phoneFiled.becomeFirstResponder()
    }
    
    @MainActor
    deinit {
        stopCountdown()
    }
    
}

extension LoginViewController {
    
    private func setupButtonActions() {
        loginView.codeBtn.addTarget(self, action: #selector(getVerificationCode), for: .touchUpInside)
        loginView.loginBtn.addTarget(self, action: #selector(getLogin), for: .touchUpInside)
    }
    
    @objc func getVerificationCode() {
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
