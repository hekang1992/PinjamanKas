//
//  ProductListView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Kingfisher

class ProductListView: BaseView {
    
    var model: flingingModel? {
        didSet {
            guard let model = model else { return }
            let cronies = model.cronies ?? 0
            
            typeImageView.isHidden = cronies == 1 ? false : true
            
            bgImageView.image = cronies == 1 ? UIImage(named: "su_co_image") : UIImage(named: "sua_co_image")
            
            let logoUrl = model.lucrative ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            
            nameLabel.text = model.uptown ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "su_g_co_image")
        return typeImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hex: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(typeImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 130, height: 72))
        }
        typeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.left.equalToSuperview().inset(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(42)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
