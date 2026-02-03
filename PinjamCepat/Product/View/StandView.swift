//
//  StandView.swift
//  PinjamCepat
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class StandView: BaseView {
    
    var cancelBlock: (() -> Void)?
    
    var goBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == "701" ? UIImage(named: "id_c_l_image") : UIImage(named: "eid_c_l_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setBackgroundImage(UIImage(named: "wltc_gb_ic"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var goBtn: UIButton = {
        let goBtn = UIButton(type: .custom)
        goBtn.addTarget(self, action: #selector(goClick), for: .touchUpInside)
        return goBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return twoBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(cancelBtn)
        bgImageView.addSubview(goBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 346))
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.top).offset(-36)
            make.right.equalTo(bgImageView)
            make.width.height.equalTo(24)
        }
        goBtn.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        twoBtn.snp.makeConstraints { make in
            make.bottom.equalTo(goBtn.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StandView {
    
    @objc func cancelClick() {
        self.cancelBlock?()
    }
    
    @objc func goClick() {
        self.goBlock?()
    }
    
    
}
