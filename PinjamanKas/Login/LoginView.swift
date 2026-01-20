//
//  LoginView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    let languageCode = LanguageManager.shared.getLanguage()
    
    var backBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_bg_imgae")
        return bgImageView
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "back_pop_image"), for: .normal)
        backBtn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        return backBtn
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "l_log_b_image")
        logoImageView.layer.cornerRadius = 7
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.init(hex: "#030305")?.cgColor
        return logoImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .center
        descLabel.text = languageCode == "701" ? "Pinjaman Kas temui anda yang lebih baik" : "Pinjaman Kas meet a better you"
        descLabel.numberOfLines = 0
        descLabel.textColor = UIColor.init(hex: "#030305")
        descLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return descLabel
    }()
    
    lazy var pImageView: UIImageView = {
        let pImageView = UIImageView()
        pImageView.image = UIImage(named: "lo_p_c_image")
        pImageView.isUserInteractionEnabled = true
        return pImageView
    }()
    
    lazy var cImageView: UIImageView = {
        let cImageView = UIImageView()
        cImageView.image = UIImage(named: "lo_p_c_image")
        cImageView.isUserInteractionEnabled = true
        return cImageView
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        loginBtn.setBackgroundImage(UIImage(named: "login_fa_b_iomge"), for: .normal)
        loginBtn.setTitle(languageCode == "701" ? "Masuk" : "Log in", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        return loginBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.isSelected = true
        sureBtn.setImage(UIImage(named: "sure_nor_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "sure_sel_image"), for: .selected)
        sureBtn.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        return sureBtn
    }()
    
    private lazy var loanLabel: UILabel = {
        
        let fullText = languageCode == "701" ? "Saya telah membaca dan menyetujui  <Kebijakan Privasi>" : "I have read and agree to the <Privacy policy>"
        let targetText = languageCode == "701" ? "<Kebijakan Privasi>" : "<Privacy policy>"
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = true
        label.textColor = UIColor.init(hex: "#9D9D9F")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: targetText)
        
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .medium), range: range)
        }
        
        label.attributedText = attributedString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTextTap(_:)))
        label.addGestureRecognizer(tapGesture)
        
        return label
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.text = languageCode == "701" ? "Nomor ponsel" : "Mobile phone number"
        oneLabel.textColor = UIColor.init(hex: "#FFFFFF")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .center
        twoLabel.text = languageCode == "701" ? "+62" : "+91"
        twoLabel.textColor = UIColor.init(hex: "#030305")
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return twoLabel
    }()
    
    lazy var phoneFiled: UITextField = {
        let phoneFiled = UITextField()
        phoneFiled.keyboardType = .numberPad
        phoneFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        phoneFiled.textColor = UIColor.init(hex: "#030305")
        phoneFiled.placeholder = languageCode == "701" ? "Nomor ponsel" : "Mobile phone number"
        return phoneFiled
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.text = languageCode == "701" ? "Kode verifikasi" : "Verification code"
        threeLabel.textColor = UIColor.init(hex: "#FFFFFF")
        threeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return threeLabel
    }()
    
    lazy var codeFiled: UITextField = {
        let codeFiled = UITextField()
        codeFiled.keyboardType = .numberPad
        codeFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        codeFiled.textColor = UIColor.init(hex: "#030305")
        codeFiled.placeholder = languageCode == "701" ? "Kode verifikasi" : "Verification code"
        return codeFiled
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.backgroundColor = UIColor(hex: "#CDF300")
        codeBtn.layer.cornerRadius = 12
        codeBtn.layer.masksToBounds = true
        codeBtn.layer.borderWidth = 1
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        codeBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        codeBtn.layer.borderColor = UIColor.init(hex: "#030305")?.cgColor
        codeBtn.setTitle(languageCode == "701" ? "Dapatkan kode" : "Get code", for: .normal)
        return codeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(backBtn)
        addSubview(scrollView)
        scrollView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(descLabel)
        bgView.addSubview(pImageView)
        bgView.addSubview(cImageView)
        bgView.addSubview(loginBtn)
        bgView.addSubview(sureBtn)
        bgView.addSubview(loanLabel)
        
        pImageView.addSubview(oneLabel)
        pImageView.addSubview(twoLabel)
        pImageView.addSubview(phoneFiled)
        
        cImageView.addSubview(threeLabel)
        cImageView.addSubview(codeBtn)
        cImageView.addSubview(codeFiled)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(39)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(2)
            make.size.equalTo(CGSize(width: 335, height: 600))
            make.bottom.equalToSuperview().offset(-80)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(110)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            if languageCode == "701" {
                make.size.equalTo(CGSize(width: 228, height: 50))
            }else {
                make.size.equalTo(CGSize(width: 201, height: 50))
            }
        }
        pImageView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 88))
        }
        cImageView.snp.makeConstraints { make in
            make.top.equalTo(pImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 88))
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 50))
            make.top.equalTo(cImageView.snp.bottom).offset(30)
        }
        sureBtn.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.top.equalTo(loginBtn.snp.bottom).offset(24)
            if languageCode == "701" {
                make.left.equalToSuperview().offset(20)
            }else {
                make.left.equalToSuperview().offset(52)
            }
        }
        loanLabel.snp.makeConstraints { make in
            make.left.equalTo(sureBtn.snp.right).offset(4)
            make.top.equalTo(loginBtn.snp.bottom).offset(24)
            if languageCode == "701" {
                make.size.equalTo(CGSize(width: 280, height: 32))
            }else {
                make.size.equalTo(CGSize(width: 212, height: 32))
            }
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(14)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.size.equalTo(CGSize(width: 30, height: 15))
            make.top.equalTo(oneLabel.snp.bottom).offset(30)
        }
        
        phoneFiled.snp.makeConstraints { make in
            make.centerY.equalTo(twoLabel)
            make.left.equalTo(twoLabel.snp.right).offset(14)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-15)
        }
        
        threeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(14)
        }
        
        codeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(threeLabel.snp.bottom).offset(25)
            if languageCode == "701" {
                make.size.equalTo(CGSize(width: 104, height: 24))
            }else {
                make.size.equalTo(CGSize(width: 66, height: 24))
            }
        }
        
        codeFiled.snp.makeConstraints { make in
            make.centerY.equalTo(codeBtn)
            make.left.equalTo(threeLabel)
            make.height.equalTo(40)
            make.right.equalTo(codeBtn.snp.left).offset(-15)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    
    @objc func backClick() {
        self.backBlock?()
    }
    
    @objc func sureClick() {
        sureBtn.isSelected.toggle()
    }
    
    @objc private func handleTextTap(_ gesture: UITapGestureRecognizer) {
        ToastManager.showMessage("登陆协议====")
    }
    
    @objc func loginClick() {
        
    }
    
}
