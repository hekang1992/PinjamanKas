//
//  HomeCardView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class HomeCardView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "main_pro_bg_image")
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hex: "#030305")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(600))
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hex: "#3C4600")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hex: "#030305")
        twoLabel.font = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight(700))
        return twoLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 335, height: 188))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(19)
            make.width.height.equalTo(34)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(9)
            make.height.equalTo(20)
        }
        oneLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(53)
            make.height.equalTo(16)
        }
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(oneLabel.snp.bottom).offset(8)
            make.height.equalTo(38)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
