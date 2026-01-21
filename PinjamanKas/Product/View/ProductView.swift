//
//  ProductView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class ProductView: BaseView {
    
    var model: retainerModel? {
        didSet {
            guard let model = model else { return }
            
            oneItemView.oneLabel.text = model.meadowbrook?.causeway?.uptown ?? ""
            oneItemView.twoLabel.text = model.meadowbrook?.causeway?.merrick ?? ""
            
            twoItemView.oneLabel.text = languageCode == "701" ? "Tenor pinjaman" : "Loan term"
            twoItemView.twoLabel.text = model.drove ?? ""
            
            nameLabel.text = model.rats ?? ""
            
            oneLabel.text = "\(model.continued ?? ""):"
            twoLabel.text = model.meadowbrook?.toes?.merrick ?? ""
        }
    }
    
    var nextBlock: (() -> Void)?
    
    var tapListBlock: ((flingingModel) -> Void)?
        
    var modelArray: [flingingModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            createListView(with: modelArray)
        }
    }
    
    private var listItemViews: [UIView] = []

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "de_tail_bg_image")
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
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "pro_de_he_image")
        return headImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.init(hex: "#030305")?.cgColor
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hex: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hex: "#FFFFFF")
        oneLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hex: "#FFFFFF")
        twoLabel.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        return twoLabel
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
    
    lazy var contentListView: UIView = {
        let contentListView = UIView()
        return contentListView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.text = languageCode == "701" ? "Syarat sertifikasi" : "Certification conditions"
        descLabel.textColor = UIColor.init(hex: "#030305")
        descLabel.font = UIFont.systemFont(ofSize: 15, weight: .black)
        return descLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        applyBtn.setBackgroundImage(UIImage(named: "apply_b_image"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyClick), for: .touchUpInside)
        return applyBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImageView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(oneItemView)
        contentView.addSubview(twoItemView)
        scrollView.addSubview(headImageView)
        scrollView.addSubview(descLabel)
        scrollView.addSubview(contentListView)
        
        headImageView.addSubview(logoImageView)
        headImageView.addSubview(nameLabel)
        headImageView.addSubview(oneLabel)
        headImageView.addSubview(twoLabel)
        
        addSubview(applyBtn)
    }
    
    private func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(60)
            make.left.right.bottom.equalToSuperview()
        }
        
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 127))
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(18)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
            make.height.equalTo(16)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.top.equalTo(oneLabel.snp.bottom).offset(5)
            make.height.equalTo(38)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(15)
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
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(twoItemView.snp.bottom).offset(20)
            make.left.equalTo(contentView)
            make.height.equalTo(16)
        }
        
        contentListView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            make.height.equalTo(0)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.size.equalTo(CGSize(width: 335, height: 50))
        }
    }
    
    private func createListView(with models: [flingingModel]) {
        listItemViews.forEach { $0.removeFromSuperview() }
        listItemViews.removeAll()
        
        let columns = 2
        let rows = Int(ceil(Double(models.count) / Double(columns)))
        
        let itemWidth: CGFloat = 160
        let itemHeight: CGFloat = 164
        let horizontalSpacing: CGFloat = (335 - itemWidth * 2) / 1
        let verticalSpacing: CGFloat = 10
        
        for (index, model) in models.enumerated() {
            let row = index / columns
            let column = index % columns
            
            let itemView = createItemView(for: model, at: index)
            contentListView.addSubview(itemView)
            listItemViews.append(itemView)
            
            itemView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(CGFloat(row) * (itemHeight + verticalSpacing))
                make.left.equalToSuperview().offset(CGFloat(column) * (itemWidth + horizontalSpacing))
                make.size.equalTo(CGSize(width: itemWidth, height: itemHeight))
            }
        }
        
        let totalHeight = CGFloat(rows) * itemHeight + CGFloat(rows - 1) * verticalSpacing
        contentListView.snp.updateConstraints { make in
            make.height.equalTo(totalHeight)
        }
        
        DispatchQueue.main.async {
            let bottomPadding: CGFloat = 20
            let totalContentHeight = self.contentListView.frame.maxY + bottomPadding
            
            self.scrollView.contentSize = CGSize(
                width: self.scrollView.frame.width,
                height: max(totalContentHeight, self.scrollView.frame.height + 1)
            )
        }
    }
    
    private func createItemView(for model: flingingModel, at index: Int) -> UIView {
        let itemView = ProductListView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
        itemView.addGestureRecognizer(tapGesture)
        itemView.tag = index
        itemView.isUserInteractionEnabled = true
        itemView.model = model
        return itemView
    }
    
    @objc private func itemTapped(_ gesture: UITapGestureRecognizer) {
        guard let index = gesture.view?.tag else { return }
        if let model = modelArray?[index] {
            self.tapListBlock?(model)
        }
    }
}

extension ProductView {
    
    @objc func applyClick() {
        self.nextBlock?()
    }
}
