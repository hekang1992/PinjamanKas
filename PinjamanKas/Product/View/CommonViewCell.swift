//
//  CommonViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/21.
//

import UIKit
import SnapKit

class CommonViewCell: UITableViewCell {
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            nameLabel.text = title
            nameField.placeholder = title
        }
    }
    
    var name: String? {
        didSet {
            guard let name = name else { return }
            if name.isEmpty || name == "//" {
                nameField.text = ""
            }else {
                nameField.text = name
            }
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "lo_p_c_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hex: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return nameLabel
    }()
    
    lazy var nameField: UITextField = {
        let nameField = UITextField()
        nameField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        nameField.textColor = UIColor.init(hex: "#030305")
        nameField.addTarget(self, action: #selector(nameFieldDidChange(_:)), for: .editingChanged)
        return nameField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(nameField)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 88))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(14)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalTo(nameLabel)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommonViewCell {
    
    @objc private func nameFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        print("输入的内容: \(text)")
    }
    
}
