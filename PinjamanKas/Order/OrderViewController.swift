//
//  OrderViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class OrderViewController: BaseViewController {
    
    var type: String = ""
    
    private var selectedButton: UIButton?
    
    lazy var orderView: OrderView = {
        let orderView = OrderView(frame: .zero)
        return orderView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = languageCode == "701" ? UIImage(named: "ad_h_id_image") : UIImage(named: "ad_h_en_image")
        return oneImageView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
        oneBtn.layer.cornerRadius = 12
        oneBtn.layer.masksToBounds = true
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        oneBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        oneBtn.setTitle(languageCode == "762" ? "All" : "Semua", for: .normal)
        oneBtn.layer.borderWidth = 1
        oneBtn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(appHeadView)
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        view.addSubview(oneImageView)
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appHeadView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 335, height: 127))
        }
        
        appHeadView.nameLabel.text = languageCode == "701" ? "Daftar pesanan" : "Order list"
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 335, height: 40))
        }
        
        contentView.addSubview(oneBtn)
        contentView.addSubview(twoBtn)
        contentView.addSubview(threeBtn)
        contentView.addSubview(fourBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 38))
            make.bottom.equalToSuperview().offset(-12)
        }
        twoBtn.snp.makeConstraints { make in
            make.left.equalTo(oneBtn.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 80, height: 38))
            make.bottom.equalToSuperview().offset(-12)
        }
        threeBtn.snp.makeConstraints { make in
            make.left.equalTo(twoBtn.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 80, height: 38))
            make.bottom.equalToSuperview().offset(-12)
        }
        fourBtn.snp.makeConstraints { make in
            make.left.equalTo(threeBtn.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 80, height: 38))
            make.bottom.equalToSuperview().offset(-12)
        }
        
        setupInitialSelectedButton()
    }
    
    private func setupInitialSelectedButton() {
        var initialButton: UIButton?
        
        switch type {
        case "4":
            initialButton = oneBtn
            
        case "7":
            initialButton = twoBtn
            
        case "6":
            initialButton = threeBtn
            
        case "5":
            initialButton = fourBtn
            
        default:
            initialButton = oneBtn
        }
        
        if let button = initialButton {
            selectButton(button)
        }
    }
    
}

extension OrderViewController {
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:
            // All按钮点击处理
            break
            
        case 1:
            // Applying按钮点击处理
            break
            
        case 2:
            // Repayment按钮点击处理
            break
            
        case 3:
            // Finished按钮点击处理
            break
            
        default:
            break
        }
        
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
