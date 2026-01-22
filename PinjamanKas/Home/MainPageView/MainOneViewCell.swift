//
//  MainOneViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit

class MainOneViewCell: UITableViewCell {
    
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgImageView)
        contentView.addSubview(applyBtn)
        
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
