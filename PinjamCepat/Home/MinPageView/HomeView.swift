//
//  HomeView.swift
//  PinjamCepat
//
//  Created by Emma Johnson on 2026/1/20.
//

import UIKit
import SnapKit
import Kingfisher

class HomeView: BaseView {
    
    var listModel: lighterModel? {
        didSet {
            guard let listModel = listModel else { return }
            let deserted = listModel.deserted ?? ""
            let wood = listModel.wood ?? ""
            oneItemView.oneLabel.text = deserted
            oneItemView.twoLabel.text = wood
            
            let gleaming = listModel.gleaming ?? ""
            let gled = listModel.gled ?? ""
            twoItemView.oneLabel.text = gleaming
            twoItemView.twoLabel.text = gled
            
            let logoUrl = listModel.emerge ?? ""
            let name = listModel.rats ?? ""
            
            cardView.logoImageView.kf.setImage(with: URL(string: logoUrl))
            cardView.nameLabel.text = name
            cardView.oneLabel.text = listModel.stalk ?? ""
            cardView.twoLabel.text = listModel.microphone ?? ""
            
            applyBtn.setTitle(listModel.soltozzo ?? "", for: .normal)
        }
    }
    
    var clickBlock: ((String) -> Void)?
    
    var mentBlock: (() -> Void)?
    
    var oneBlock: (() -> Void)?
    var twoBlock: (() -> Void)?
    var threeBlock: (() -> Void)?
    var fourBlock: ((String) -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "home_gb_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var headView: HomeHeadView = {
        let headView = HomeHeadView(frame: .zero)
        return headView
    }()
    
    lazy var oneItemView: HomeItemView = {
        let oneItemView = HomeItemView(frame: .zero)
        oneItemView.logoImageView.image = UIImage(named: "home_lef_f_image")
        return oneItemView
    }()
    
    lazy var twoItemView: HomeItemView = {
        let twoItemView = HomeItemView(frame: .zero)
        twoItemView.logoImageView.image = UIImage(named: "home_ei_f_image")
        return twoItemView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var cardView: HomeCardView = {
        let cardView = HomeCardView(frame: .zero)
        return cardView
    }()
    
    lazy var mentView: HomeMentView = {
        let mentView = HomeMentView(frame: .zero)
        mentView.meBlock = { [weak self] in
            self?.mentBlock?()
        }
        return mentView
    }()
    
    lazy var stepView: HomeAuthStepView = {
        let stepView = HomeAuthStepView(frame: .zero)
        return stepView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        applyBtn.setBackgroundImage(UIImage(named: "apply_b_image"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyClick), for: .touchUpInside)
        return applyBtn
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: languageCode == "701" ? "ni_bg_f_image" : "desc_oc_image")
        descImageView.isUserInteractionEnabled = true
        return descImageView
    }()
    
    lazy var mscrollView: UIScrollView = {
        let mscrollView = UIScrollView()
        mscrollView.showsHorizontalScrollIndicator = false
        mscrollView.showsVerticalScrollIndicator = false
        mscrollView.backgroundColor = .clear
        return mscrollView
    }()
    
    lazy var footLabel: UILabel = {
        let footLabel = UILabel()
        footLabel.textAlignment = .left
        footLabel.text = "User reviews"
        footLabel.textColor = UIColor.init(hex: "#030305")
        footLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return footLabel
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "foot_d_i_image")
        return footImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.addTarget(self, action: #selector(applyClick), for: .touchUpInside)
        return clickBtn
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.addTarget(self, action: #selector(oneBtnClick), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.addTarget(self, action: #selector(twoBtnClick), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.addTarget(self, action: #selector(threeBtnClick), for: .touchUpInside)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.addTarget(self, action: #selector(fourBtnClick), for: .touchUpInside)
        return fourBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(headView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(oneItemView)
        contentView.addSubview(twoItemView)
        scrollView.addSubview(cardView)
        if languageCode == "701" {
            scrollView.addSubview(stepView)
        }else {
            scrollView.addSubview(mentView)
        }
        
        scrollView.addSubview(applyBtn)
        scrollView.addSubview(clickBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(335)
            make.centerX.equalToSuperview()
            make.height.equalTo(93)
        }
        oneItemView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 160, height: 93))
        }
        twoItemView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 160, height: 93))
        }
        cardView.snp.makeConstraints { make in
            make.top.equalTo(twoItemView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 199))
        }
        
        if languageCode == "701" {
            stepView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.left.equalTo(cardView).offset(10)
                make.top.equalTo(cardView.snp.bottom).offset(10)
                make.height.equalTo(40)
            }
        }else {
            mentView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.left.equalTo(cardView).offset(10)
                make.top.equalTo(cardView.snp.bottom).offset(10)
                make.height.equalTo(32)
            }
        }
        
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            if languageCode == "701" {
                make.top.equalTo(stepView.snp.bottom).offset(19)
            }else {
                make.top.equalTo(mentView.snp.bottom).offset(19)
            }
            make.size.equalTo(CGSize(width: 335, height: 50))
        }
        clickBtn.snp.makeConstraints { make in
            make.top.equalTo(cardView)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(cardView)
        }
        
        if languageCode == "762" {
            scrollView.addSubview(descImageView)
            scrollView.addSubview(footLabel)
            scrollView.addSubview(mscrollView)
            mscrollView.addSubview(footImageView)
            descImageView.addSubview(oneBtn)
            descImageView.addSubview(twoBtn)
            descImageView.addSubview(threeBtn)
            descImageView.addSubview(fourBtn)
            
            descImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(applyBtn.snp.bottom).offset(20)
                make.size.equalTo(CGSize(width: 335, height: 237))
            }
            footLabel.snp.makeConstraints { make in
                make.top.equalTo(descImageView.snp.bottom).offset(15)
                make.left.equalTo(descImageView)
                make.height.equalTo(15)
            }
            mscrollView.snp.makeConstraints { make in
                make.top.equalTo(footLabel.snp.bottom).offset(15)
                make.left.equalTo(footLabel)
                make.centerX.equalToSuperview()
                make.height.equalTo(76)
                make.bottom.equalToSuperview().offset(-80)
            }
            footImageView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.size.equalTo(CGSize(width: 485, height: 76))
                make.right.equalToSuperview().offset(-20)
            }
            
            oneBtn.snp.makeConstraints { make in
                make.top.left.equalToSuperview()
                make.size.equalTo(CGSize(width: 112, height: 120))
            }
            
            twoBtn.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalTo(oneBtn.snp.right)
                make.size.equalTo(CGSize(width: 112, height: 120))
            }
            
            threeBtn.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalTo(twoBtn.snp.right)
                make.size.equalTo(CGSize(width: 112, height: 120))
            }
            
            fourBtn.snp.makeConstraints { make in
                make.bottom.left.right.equalToSuperview()
                make.height.equalTo(120)
            }
            
        }else {
            scrollView.addSubview(descImageView)
            descImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(applyBtn.snp.bottom).offset(20)
                make.size.equalTo(CGSize(width: 335, height: 218))
                make.bottom.equalToSuperview().offset(-80)
            }
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView {
    
    @objc private func applyClick() {
        if let listModel = listModel {
            self.clickBlock?(String(listModel.holes ?? 0))
        }
    }
    
    @objc func oneBtnClick() {
        self.oneBlock?()
    }
    
    @objc func twoBtnClick() {
        self.twoBlock?()
    }
    
    @objc func threeBtnClick() {
        self.threeBlock?()
    }
    
    @objc func fourBtnClick() {
        if let listModel = listModel {
            self.fourBlock?(String(listModel.holes ?? 0))
        }
    }
    
}
