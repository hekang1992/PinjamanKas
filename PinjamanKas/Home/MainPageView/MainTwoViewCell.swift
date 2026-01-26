//
//  MainTwoViewCell.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit
import FSPagerView

class MainTwoViewCell: UITableViewCell {
    
    var tapBlock: ((lighterModel) -> Void)?
    
    var modelArray: [lighterModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            pagerView.reloadData()
        }
    }

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.init(hex: "#F1F1F3")?.cgColor
        bgView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return bgView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "ra_arr_image")
        return arrowImageView
    }()
    
    lazy var pagerView: FSPagerView = {
        let pv = FSPagerView()
        pv.dataSource = self
        pv.delegate = self
        pv.register(CustomPagerCell.self, forCellWithReuseIdentifier: "CustomPagerCell")
        pv.interitemSpacing = 5
        pv.transformer = FSPagerViewTransformer(type: .linear)
        pv.isInfinite = true
        pv.automaticSlidingInterval = 3.0
        pv.backgroundColor = .clear
        pv.layer.borderWidth = 0
        return pv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(pagerView)
        bgView.addSubview(arrowImageView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 50))
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-13)
            make.width.height.equalTo(15)
        }
        pagerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainTwoViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let model = self.modelArray?[index]
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CustomPagerCell", at: index) as! CustomPagerCell
        cell.titleLabel.text = model?.strangler ?? ""
        
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        
        cell.contentView.transform = CGAffineTransform.identity
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let model = self.modelArray?[index] {
            self.tapBlock?(model)
        }
    }
    
}
