//
//  HomeAuthStepView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/2/2.
//

import UIKit
import SnapKit

class HomeAuthStepView: UIView {
    
    var type: String? {
        didSet {
            guard let type = type else { return }
            switch type {
            case "extreme1":
                self.nameLabel.text = "0%\ntersisa"
                self.nameLabel.snp.updateConstraints { make in
                    make.left.equalToSuperview().offset(327 * 0)
                }
                
            case "extreme3":
                self.nameLabel.text = "25%\ntersisa"
                self.nameLabel.snp.updateConstraints { make in
                    make.left.equalToSuperview().offset(327 * 0.25 - 32)
                }
                
            case "extreme4":
                self.nameLabel.text = "50%\ntersisa"
                self.nameLabel.snp.updateConstraints { make in
                    make.left.equalToSuperview().offset(327 * 0.5 - 32)
                }
                
            case "extreme5":
                self.nameLabel.text = "75%\ntersisa"
                self.nameLabel.snp.updateConstraints { make in
                    make.left.equalToSuperview().offset(327 * 0.75 - 32)
                }
            case "":
                self.nameLabel.text = "100%\ntersisa"
                self.nameLabel.snp.updateConstraints { make in
                    make.left.equalToSuperview().offset(327 * 1 - 32)
                }
                
            default:
                break
            }
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hex: "#F1F1F3")
        return bgView
    }()
    
    lazy var leftLabel: UILabel = {
        let leftLabel = UILabel()
        leftLabel.textAlignment = .left
        leftLabel.text = "Informasi yang sempurna"
        leftLabel.textColor = UIColor.init(hex: "#9D9D9F")
        leftLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return leftLabel
    }()
    
    lazy var rightLabel: UILabel = {
        let rightLabel = UILabel()
        rightLabel.textAlignment = .right
        rightLabel.text = "Dapatkan kuota"
        rightLabel.textColor = UIColor.init(hex: "#9D9D9F")
        rightLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return rightLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hex: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        nameLabel.layer.cornerRadius = 12
        nameLabel.layer.masksToBounds = true
        nameLabel.text = "0%\ntersisa"
        nameLabel.numberOfLines = 0
        nameLabel.backgroundColor = UIColor.init(hex: "#CDF300")
        return nameLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 4
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hex: "#CDF300")
        return lineView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(nameLabel)
        addSubview(lineView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(327)
            make.left.equalToSuperview()
            make.height.equalTo(8)
        }
        leftLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(12)
        }
        rightLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(12)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 62, height: 26))
        }
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalTo(bgView)
            make.right.equalTo(nameLabel.snp.left).offset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
