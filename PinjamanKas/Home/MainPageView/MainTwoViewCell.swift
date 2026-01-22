//
//  MainTwoViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit

class MainTwoViewCell: UITableViewCell {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.init(hex: "#F1F1F3")?.cgColor
        bgView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return bgView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "ra_arr_image")
        return arrowImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(arrowImageView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 50))
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-13)
            make.width.height.equalTo(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
