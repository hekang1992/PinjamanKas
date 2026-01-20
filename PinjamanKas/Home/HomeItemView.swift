//
//  HomeItemView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class HomeItemView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "left_bg_image")
        return bgImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hex: "#FFFFFF")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hex: "#030305")
        twoLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return twoLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(logoImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(12)
        }
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 97, height: 20))
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(twoLabel)
            make.width.height.equalTo(20)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
