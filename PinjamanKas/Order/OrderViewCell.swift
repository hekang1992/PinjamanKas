//
//  OrderViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit
import Kingfisher

class OrderViewCell: UITableViewCell {
    
    var model: magicallyModel? {
        didSet {
            guard let model = model else { return }
            let possibly = model.possibly ?? 0
            
            switch possibly {
            case 1:
                headView.backgroundColor = UIColor(hex: "#FFF3F3")
                
            case 2:
                headView.backgroundColor = UIColor(hex: "#FAFEE6")
                
            case 3:
                headView.backgroundColor = UIColor(hex: "#FFFCF2")
                
            case 4:
                headView.backgroundColor = UIColor(hex: "#F6F6F6")
                
            default:
                headView.backgroundColor = .white
            }
            
            nameLabel.text = model.rats ?? ""
            logoImageView.kf.setImage(with: URL(string: model.emerge ?? ""))
            oneLabel.text = model.LoanAmountText ?? ""
            twoLabel.text = model.moneyContent ?? ""
            threeLabel.text = model.irritation ?? ""
            fourLabel.text = model.dateContent ?? ""
            typeLabel.text = model.soltozzo ?? ""
        }
    }

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.init(hex: "#F1F1F3")?.cgColor
        return bgView
    }()
    
    lazy var headView: UIView = {
        let headView = UIView()
        headView.layer.cornerRadius = 18
        headView.layer.masksToBounds = true
        headView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return headView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hex: "#111111")
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(300))
        return nameLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.init(hex: "#000000")?.cgColor
        return logoImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hex: "#9D9D9F")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(300))
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .right
        twoLabel.textColor = UIColor.init(hex: "#030305")
        twoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.textColor = UIColor.init(hex: "#9D9D9F")
        threeLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(300))
        return threeLabel
    }()
    
    lazy var fourLabel: UILabel = {
        let fourLabel = UILabel()
        fourLabel.textAlignment = .right
        fourLabel.textColor = UIColor.init(hex: "#030305")
        fourLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(700))
        return fourLabel
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .left
        typeLabel.textColor = UIColor.init(hex: "#FFFFFF")
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return typeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(headView)
        headView.addSubview(nameLabel)
        headView.addSubview(logoImageView)
        headView.addSubview(typeLabel)
        bgView.addSubview(oneLabel)
        bgView.addSubview(twoLabel)
        bgView.addSubview(threeLabel)
        bgView.addSubview(fourLabel)
        bgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 335, height: 184))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-8)
        }
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(42)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(14)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(18)
            make.right.equalTo(nameLabel.snp.left).offset(-4)
        }
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(14)
        }
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(headView.snp.bottom).offset(13)
            make.height.equalTo(14)
        }
        twoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(oneLabel)
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(16)
        }
        threeLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(7)
            make.left.equalTo(oneLabel)
            make.height.equalTo(14)
        }
        fourLabel.snp.makeConstraints { make in
            make.centerY.equalTo(threeLabel)
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
