//
//  SettingViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class SettingViewController: BaseViewController {
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 14
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.white
        oneView.layer.borderWidth = 1
        oneView.layer.borderColor = UIColor.init(hex: "#F1F1F3")?.cgColor
        return oneView
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 14
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.white
        twoView.layer.borderWidth = 1
        twoView.layer.borderColor = UIColor.init(hex: "#F1F1F3")?.cgColor
        twoView.isHidden = languageCode == "701" ? true : false
        return twoView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.text = languageCode == "701" ? "Keluar" : "Log out"
        oneLabel.textColor = UIColor.init(hex: "#030305")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLabel
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "ra_arr_image")
        return oneImageView
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.text = "Delete"
        twoLabel.textColor = UIColor.init(hex: "#8D8E96")
        twoLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return twoLabel
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "ra_arr_image")
        return twoImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ce_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(appHeadView)
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        appHeadView.nameLabel.text = languageCode == "701" ? "Pengaturan" : "Set up"
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "cd_d_image")
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appHeadView.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 123, height: 170))
        }
        
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327, height: 50))
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
        }
        
        view.addSubview(twoView)
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327, height: 50))
            make.top.equalTo(twoView.snp.bottom).offset(20)
        }
        
        oneView.addSubview(oneLabel)
        oneView.addSubview(oneImageView)
        
        oneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        oneImageView.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        twoView.addSubview(twoLabel)
        twoView.addSubview(twoImageView)
        
        twoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        twoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
    }
    
}
