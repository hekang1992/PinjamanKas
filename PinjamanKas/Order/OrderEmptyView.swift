//
//  OrderEmptyView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit

class OrderEmptyView: BaseView {
    
    var clickBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == "701" ? UIImage(named: "iep_d_image") : UIImage(named: "ep_d_image")
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBgImageTap))
        bgImageView.addGestureRecognizer(tapGesture)
        
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.size.equalTo(CGSize(width: 206, height: 180))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OrderEmptyView {
    
    @objc private func handleBgImageTap() {
        self.clickBlock?()
    }
    
}
