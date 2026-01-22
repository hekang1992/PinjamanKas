//
//  MainProductListViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit

class MainProductListViewCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.init(hex: "#9CB900")?.cgColor
        bgView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return bgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 90))
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
