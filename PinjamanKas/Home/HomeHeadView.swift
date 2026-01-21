//
//  HomeHeadView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class HomeHeadView: BaseView {
        
    let phone = UserManager.shared.getPhone()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "ho_lo_c_image")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == "762" ? "Hey" : "Hai"
        nameLabel.textColor = UIColor.init(hex: "#555556")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return nameLabel
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        phoneLabel.text = PhoneNumberFormatter.mask(phone)
        phoneLabel.textColor = UIColor.init(hex: "#000000")
        phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        return phoneLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(phoneLabel)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(26)
            make.left.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(15)
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.height.equalTo(18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PhoneNumberFormatter {
    
    static func mask(_ phone: String) -> String {
        guard phone.count >= 8 else {
            return phone
        }
        
        let prefix = String(phone.prefix(3))
        let suffix = String(phone.suffix(2))
        let starCount = max(phone.count - 5, 3)
        
        return "\(prefix)" + String(repeating: "*", count: starCount) + "\(suffix)"
    }
}
