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
            guard let modelArray = modelArray else { return }
            tableView.reloadData()
        }
    }
        
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
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
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
        return modelArray?[section].lighter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = modelArray?[indexPath.section].appear ?? ""
        let listArray = modelArray?[indexPath.section].lighter ?? []
        switch type {
        case "wedding3":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainOneViewCell", for: indexPath) as! MainOneViewCell
            return cell
            
        case "wedding4":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTwoViewCell", for: indexPath) as! MainTwoViewCell
            return cell
            
        case "wedding5":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainProductListViewCell", for: indexPath) as! MainProductListViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
}
