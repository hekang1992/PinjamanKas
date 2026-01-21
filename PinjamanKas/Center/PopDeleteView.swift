//
//  PopDeleteView 2.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//


import UIKit
import SnapKit

class PopDeleteView: BaseView {
    
    var cancelBlock: (() -> Void)?
    
    var sureBlock: (() -> Void)?
        
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: languageCode == "701" ? "del_le_image" : "del_le_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle(languageCode == "701" ? "Cancel" : "Cancel", for: .normal)
        cancelBtn.setTitleColor(.black, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cancelBtn.setBackgroundImage(UIImage(named: "out_da_b_image"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitle(languageCode == "701" ? "Delete" : "Delete", for: .normal)
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
    
    lazy var mentBtn: UIButton = {
        let mentBtn = UIButton(type: .custom)
        mentBtn.setImage(UIImage(named: "sure_nor_image"), for: .normal)
        mentBtn.setImage(UIImage(named: "sure_sel_image"), for: .selected)
        mentBtn.addTarget(self, action: #selector(mentClick), for: .touchUpInside)
        return mentBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "I have read and agree to the above"
        nameLabel.textColor = UIColor.init(hex: "#9D9D9F")
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(sureBtn)
        bgImageView.addSubview(lineView)
        bgImageView.addSubview(mentBtn)
        bgImageView.addSubview(nameLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 382))
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
        
        mentBtn.snp.makeConstraints { make in
            make.bottom.equalTo(cancelBtn.snp.top).offset(-15)
            make.left.equalToSuperview().offset(32)
            make.width.height.equalTo(15)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mentBtn)
            make.left.equalTo(mentBtn.snp.right).offset(5)
            make.height.equalTo(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopDeleteView {
    
    @objc func mentClick() {
        mentBtn.isSelected.toggle()
    }
    
    @objc func cancelClick() {
        self.cancelBlock?()
    }
    
    @objc func sureClick() {
        self.sureBlock?()
    }
}
