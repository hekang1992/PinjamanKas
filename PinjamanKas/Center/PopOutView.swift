//
//  PopOutView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class PopOutView: UIView {
    
    var cancelBlock: (() -> Void)?
    
    var sureBlock: (() -> Void)?
    
    let languageCode = LanguageManager.shared.getLanguage()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: languageCode == "701" ? "out_led_image" : "out_le_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle(languageCode == "701" ? "Membatalkan" : "Cancel", for: .normal)
        cancelBtn.setTitleColor(.black, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cancelBtn.setBackgroundImage(UIImage(named: "out_da_b_image"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitle(languageCode == "701" ? "Keluar" : "Log out", for: .normal)
        sureBtn.setTitleColor(UIColor(hex: "#9D9D9F"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        sureBtn.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        return sureBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hex: "#9D9D9F")
        return lineView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(sureBtn)
        bgImageView.addSubview(lineView)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 351))
        }
        cancelBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 255, height: 50))
            make.bottom.equalToSuperview().offset(-53)
        }
        
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cancelBtn.snp.bottom).offset(15)
            make.height.equalTo(18)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(sureBtn)
            make.left.right.equalTo(sureBtn).inset(-1)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopOutView {
    
    @objc func cancelClick() {
        self.cancelBlock?()
    }
    
    @objc func sureClick() {
        self.sureBlock?()
    }
}
