//
//  OrderViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit

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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(headView)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
