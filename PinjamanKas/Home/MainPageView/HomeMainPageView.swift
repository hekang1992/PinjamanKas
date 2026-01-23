//
//  HomeMainPageView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import UIKit
import SnapKit
import Kingfisher

class HomeMainPageView: BaseView {
    
    var modelArray: [magicallyModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var cellTapBlock: ((lighterModel) -> Void)?
        
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "home_gb_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()

    lazy var headView: HomeHeadView = {
        let headView = HomeHeadView(frame: .zero)
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MainOneViewCell.self, forCellReuseIdentifier: "MainOneViewCell")
        tableView.register(MainTwoViewCell.self, forCellReuseIdentifier: "MainTwoViewCell")
        tableView.register(MainProductListViewCell.self, forCellReuseIdentifier: "MainProductListViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(headView)
        addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-85)
//            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeMainPageView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = modelArray?[section].appear ?? ""
        if type == "wedding4" {
            return 1
        }else {
            return modelArray?[section].lighter?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = modelArray?[indexPath.section].appear ?? ""
        let listArray = modelArray?[indexPath.section].lighter ?? []
        switch type {
        case "wedding3":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainOneViewCell", for: indexPath) as! MainOneViewCell
            cell.model = listArray[indexPath.row]
            return cell
            
        case "wedding4":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTwoViewCell", for: indexPath) as! MainTwoViewCell
            return cell
            
        case "wedding5":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainProductListViewCell", for: indexPath) as! MainProductListViewCell
            cell.model = listArray[indexPath.row]
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let type = modelArray?[section].appear ?? ""
        if type == "wedding5" {
            return 30
        }else {
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = modelArray?[section].appear ?? ""
        if type == "wedding5" {
            let headView = UIView()
            let nameLabel = UILabel()
            nameLabel.textAlignment = .left
            nameLabel.text = languageCode == "701" ? "Produk pinjaman" : "Loan products"
            nameLabel.textColor = UIColor.init(hex: "#030305")
            nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
            headView.addSubview(nameLabel)
            nameLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(335)
                make.height.equalTo(15)
            }
            return headView
        }else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listArray = modelArray?[indexPath.section].lighter ?? []
        let model = listArray[indexPath.row]
        self.cellTapBlock?(model)
    }
    
}
