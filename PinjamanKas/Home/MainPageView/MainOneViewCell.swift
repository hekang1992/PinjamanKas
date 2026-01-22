//
//  MainOneViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit
import Kingfisher

class MainOneViewCell: UITableViewCell {
    
    var model: lighterModel? {
        didSet {
            guard let model = model else { return }
            
            let logoUrl = model.emerge ?? ""
            let name = model.rats ?? ""
            
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = name
            oneLabel.text = model.stalk ?? ""
            twoLabel.text = model.microphone ?? ""
            applyBtn.setTitle(model.soltozzo ?? "", for: .normal)
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "mp_adc_image")
        return bgImageView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        applyBtn.setBackgroundImage(UIImage(named: "apply_b_image"), for: .normal)
        return applyBtn
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgImageView)
        contentView.addSubview(applyBtn)
        
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 157))
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView.snp.bottom).offset(13)
            make.size.equalTo(CGSize(width: 335, height: 50))
            make.bottom.equalToSuperview().offset(-10)
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
            make.top.equalTo(nameLabel.snp.bottom).offset(36)
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
