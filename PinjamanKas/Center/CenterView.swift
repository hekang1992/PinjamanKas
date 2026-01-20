//
//  CenterView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class CenterView: UIView {
    
    private var selectedButton: UIButton?
    
    let languageCode = LanguageManager.shared.getLanguage()
    
    let phone = UserManager.shared.getPhone()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ce_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "c_ce_ri_image")
        return rightImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "c_log_i_mage")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == "762" ? "Hey" : "Hai"
        nameLabel.textColor = UIColor.init(hex: "#555556")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return nameLabel
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        phoneLabel.text = phone
        phoneLabel.textColor = UIColor.init(hex: "#000000")
        phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        return phoneLabel
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 18
        whiteView.layer.masksToBounds = true
        whiteView.layer.borderWidth = 3
        whiteView.layer.borderColor = UIColor.init(hex: "#CDF300")?.cgColor
        return whiteView
    }()
    
    lazy var ocView: UIView = {
        let ocView = UIView()
        ocView.backgroundColor = UIColor.init(hex: "#CDF300")
        ocView.layer.cornerRadius = 18
        ocView.layer.masksToBounds = true
        return ocView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "ra_arr_image")
        return arrowImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.backgroundColor = UIColor.init(hex: "#030305")
        oneBtn.layer.cornerRadius = 12
        oneBtn.layer.masksToBounds = true
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        oneBtn.setTitleColor(.white, for: .normal)
        oneBtn.setTitle(languageCode == "762" ? "All" : "Semua", for: .normal)
        oneBtn.tag = 0
        oneBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
        twoBtn.layer.cornerRadius = 12
        twoBtn.layer.masksToBounds = true
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        twoBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        twoBtn.setTitle(languageCode == "762" ? "Applying" : "Dalam proses", for: .normal)
        twoBtn.layer.borderWidth = 1
        twoBtn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
        twoBtn.tag = 1
        twoBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
        threeBtn.layer.cornerRadius = 12
        threeBtn.layer.masksToBounds = true
        threeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        threeBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        threeBtn.setTitle(languageCode == "762" ? "Repayment" : "Belum lunas", for: .normal)
        threeBtn.layer.borderWidth = 1
        threeBtn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
        threeBtn.tag = 2
        threeBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
        fourBtn.layer.cornerRadius = 12
        fourBtn.layer.masksToBounds = true
        fourBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        fourBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        fourBtn.setTitle(languageCode == "762" ? "Finished" : "Lunas", for: .normal)
        fourBtn.layer.borderWidth = 1
        fourBtn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
        fourBtn.tag = 3
        fourBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return fourBtn
    }()
    
    lazy var mentImageView: UIImageView = {
        let mentImageView = UIImageView()
        mentImageView.backgroundColor = .systemPink
        return mentImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        selectButton(oneBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImageView)
        addSubview(rightImageView)
        addSubview(scrollView)
        
        scrollView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(phoneLabel)
        
        scrollView.addSubview(whiteView)
        whiteView.addSubview(ocView)
        ocView.addSubview(arrowImageView)
        whiteView.addSubview(oneBtn)
        whiteView.addSubview(twoBtn)
        whiteView.addSubview(threeBtn)
        whiteView.addSubview(fourBtn)
        scrollView.addSubview(mentImageView)
    }
    
    private func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().offset(-19)
            make.width.height.equalTo(22)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(rightImageView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(64)
            make.left.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(15)
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.height.equalTo(18)
        }
        
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 340, height: 108))
        }
        ocView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.left.right.equalToSuperview().inset(2)
            make.height.equalTo(43)
        }
        arrowImageView.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-18)
        }
        
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(9)
            make.size.equalTo(CGSize(width: 76, height: 38))
            make.bottom.equalToSuperview().offset(-12)
        }
        twoBtn.snp.makeConstraints { make in
            make.left.equalTo(oneBtn.snp.right).offset(6)
            make.size.equalTo(CGSize(width: 76, height: 38))
            make.bottom.equalToSuperview().offset(-12)
        }
        threeBtn.snp.makeConstraints { make in
            make.left.equalTo(twoBtn.snp.right).offset(6)
            make.size.equalTo(CGSize(width: 76, height: 38))
            make.bottom.equalToSuperview().offset(-12)
        }
        fourBtn.snp.makeConstraints { make in
            make.left.equalTo(threeBtn.snp.right).offset(6)
            make.size.equalTo(CGSize(width: 76, height: 38))
            make.bottom.equalToSuperview().offset(-12)
        }
        mentImageView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 340, height: 75))
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectButton(sender)
    }
    
    private func selectButton(_ button: UIButton) {
        
        let allButtons = [oneBtn, twoBtn, threeBtn, fourBtn]
        
        for btn in allButtons {
            if btn == button {
                btn.backgroundColor = UIColor.init(hex: "#030305")
                btn.setTitleColor(.white, for: .normal)
                btn.layer.borderWidth = 0
            } else {
                btn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
                btn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
                btn.layer.borderWidth = 1
                btn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
            }
        }
        
        selectedButton = button
        
    }
    
}
