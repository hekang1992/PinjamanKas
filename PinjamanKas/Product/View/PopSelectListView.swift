//
//  PopSelectListView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/21.
//

import UIKit
import SnapKit
import BRPickerView

class PopSelectListView: BaseView {
    
    var cancelBlock: (() -> Void)?
    
    var confirmBlock: ((offensiveModel) -> Void)?
    
    var selectedIndex: Int? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var modelArray: [offensiveModel]? {
        didSet {
//            tableView.reloadData()
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pop_selec_a_c_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hex: "#101012")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setTitle(languageCode == "701" ? "Mengonfirmasi" : "Confirm", for: .normal)
        confirmBtn.setTitleColor(.black, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        confirmBtn.setBackgroundImage(UIImage(named: "out_da_b_image"), for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
        return confirmBtn
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(confirmBtn)
        bgImageView.addSubview(tableView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 457))
        }
        cancelBtn.snp.makeConstraints { make in
            make.right.top.equalToSuperview()
            make.width.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(22)
        }
        confirmBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 305, height: 50))
            make.bottom.equalToSuperview().offset(-20)
        }
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.bottom.equalTo(confirmBtn.snp.top).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopSelectListView {
    
    @objc func cancelClick() {
        self.cancelBlock?()
    }
    
    @objc func confirmClick() {
        guard let selectedIndex = selectedIndex,
              let selectedModel = modelArray?[selectedIndex] else {
            ToastManager.showMessage(languageCode == "701" ? "Silakan pilih item autentikasi." : "Please select an authentication item.")
            return
        }
        self.confirmBlock?(selectedModel)
    }
    
    func clearSelection() {
        selectedIndex = nil
    }
    
    func setDefaultSelection(at index: Int) {
        if let count = modelArray?.count, index < count {
            selectedIndex = index
        }
    }
    
}

extension PopSelectListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelArray?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.backgroundView = nil
        cell.selectedBackgroundView = nil
        
        let isSelected = indexPath.row == selectedIndex
        
        if isSelected {
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = UIColor(hex: "#CDF300")
            selectedBackgroundView.layer.cornerRadius = 24
            selectedBackgroundView.clipsToBounds = true
            cell.backgroundView = selectedBackgroundView
            
            cell.textLabel?.textColor = UIColor(hex: "#030305")
        } else {
            cell.textLabel?.textColor = UIColor(hex: "#9D9D9F")
        }
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        cell.textLabel?.text = model?.steering ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}

