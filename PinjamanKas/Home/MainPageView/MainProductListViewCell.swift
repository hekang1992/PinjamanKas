//
//  MainProductListViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit
import Kingfisher

class MainProductListViewCell: UITableViewCell {
    
    var model: lighterModel? {
        didSet {
            guard let model = model else { return }
            applyLabel.text = model.soltozzo ?? ""
            logoImageView.kf.setImage(with: URL(string: model.emerge ?? ""))
            nameLabel.text = model.rats ?? ""
            descLabel.text = model.stalk ?? ""
            moneyLabel.text = model.microphone ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.init(hex: "#9CB900")?.cgColor
        bgView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return bgView
    }()
    
    lazy var applyImageView: UIImageView = {
        let applyImageView = UIImageView()
        applyImageView.image = UIImage(named: "mi_ap_ly_image")
        return applyImageView
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textAlignment = .center
        applyLabel.textColor = UIColor.init(hex: "#030305")
        applyLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return applyLabel
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
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(600))
        return nameLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.textColor = UIColor.init(hex: "#030305")
        moneyLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(600))
        return moneyLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hex: "#9D9D9F")
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return descLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(applyImageView)
        applyImageView.addSubview(applyLabel)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(descLabel)
        bgView.addSubview(moneyLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 90))
            make.bottom.equalToSuperview().offset(-5)
        }
        applyImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 88, height: 36))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-14)
        }
        applyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.top.left.equalToSuperview().inset(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        descLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(14)
        }
        moneyLabel.snp.makeConstraints { make in
            make.left.equalTo(descLabel)
            make.height.equalTo(16)
            make.bottom.equalTo(descLabel.snp.top).offset(-3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
