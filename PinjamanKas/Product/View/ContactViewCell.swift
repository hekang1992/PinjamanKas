//
//  ContactViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/21.
//

import UIKit
import SnapKit

class ContactViewCell: UITableViewCell {
    
    var model: magicallyModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.merrick ?? ""
            oneLabel.text = model.relationship_title ?? ""
            nameField.placeholder = model.relationship_placeholder ?? ""
            
            oLabel.text = model.contact_title ?? ""
            oField.placeholder = model.contact_placeholder ?? ""
            
            let soldiers = model.soldiers ?? ""
            let modelArray = model.opponents ?? []
            
            modelArray.forEach { model in
                if model.appear == soldiers {
                    nameField.text = model.steering ?? ""
                }
            }
            
            let phone = model.view ?? ""
            
            let name = model.steering ?? ""
            
            if phone.isEmpty || name.isEmpty {
                oField.text = ""
            }else {
                oField.text = "\(name): \(phone)"
            }
            
            
        }
    }
    
    var relationBlock: (() -> Void)?
    var contactBlock: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.white
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hex: "#030305")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "lo_p_c_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hex: "#FFFFFF")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return oneLabel
    }()
    
    lazy var nameField: UITextField = {
        let nameField = UITextField()
        nameField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        nameField.textColor = UIColor.init(hex: "#030305")
        nameField.isEnabled = false
        return nameField
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "ra_arr_image")
        return arrowImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.addTarget(self, action: #selector(relationClick), for: .touchUpInside)
        return clickBtn
    }()
    
    lazy var cImageView: UIImageView = {
        let cImageView = UIImageView()
        cImageView.image = UIImage(named: "lo_p_c_image")
        cImageView.isUserInteractionEnabled = true
        return cImageView
    }()
    
    lazy var oLabel: UILabel = {
        let oLabel = UILabel()
        oLabel.textAlignment = .left
        oLabel.textColor = UIColor.init(hex: "#FFFFFF")
        oLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return oLabel
    }()
    
    lazy var oField: UITextField = {
        let oField = UITextField()
        oField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        oField.textColor = UIColor.init(hex: "#030305")
        oField.isEnabled = false
        return oField
    }()
    
    lazy var aoImageView: UIImageView = {
        let aoImageView = UIImageView()
        aoImageView.image = UIImage(named: "ra_arr_image")
        return aoImageView
    }()
    
    lazy var cpBtn: UIButton = {
        let cpBtn = UIButton(type: .custom)
        cpBtn.addTarget(self, action: #selector(contactClick), for: .touchUpInside)
        return cpBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 250))
            make.bottom.equalToSuperview().offset(-15)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(15)
            make.height.equalTo(14)
        }
        
        
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(nameField)
        bgImageView.addSubview(arrowImageView)
        bgImageView.addSubview(clickBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 295, height: 88))
            make.centerX.equalToSuperview()
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(14)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(15)
            make.left.equalTo(oneLabel)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-35)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameField)
            make.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(15)
        }
        
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(cImageView)
        cImageView.addSubview(oLabel)
        cImageView.addSubview(oField)
        cImageView.addSubview(aoImageView)
        cImageView.addSubview(cpBtn)
        
        cImageView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 295, height: 88))
            make.centerX.equalToSuperview()
        }
        
        oLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(14)
        }
        
        oField.snp.makeConstraints { make in
            make.top.equalTo(oLabel.snp.bottom).offset(15)
            make.left.equalTo(oLabel)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-35)
        }
        
        aoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(oField)
            make.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(15)
        }
        
        cpBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ContactViewCell {
    
    @objc func relationClick() {
        self.relationBlock?()
    }
    
    @objc func contactClick() {
        self.contactBlock?()
    }
    
}
