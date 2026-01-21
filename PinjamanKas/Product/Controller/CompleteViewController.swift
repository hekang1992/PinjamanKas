//
//  CompleteViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire
internal import AVFoundation
import TYAlertController

class CompleteViewController: BaseViewController {
    
    var params: [String: String] = [:]
    
    var modelArray: [String]?
    
    private let etitles: [String] = ["Name", "ID number", "Birthday"]
    
    private let ititles: [String] = ["Nama sesuai ktp", "Nomor ktp", "Ulang tahun"]
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "pro_head_bg_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = languageCode == "701" ? UIImage(named: "pro_oy_desc_image") : UIImage(named: "pro_one_image")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = languageCode == "701" ? UIImage(named: "ca_comp_in_image") : UIImage(named: "ca_comp_en_image")
        return twoImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        applyBtn.setBackgroundImage(UIImage(named: "apply_b_image"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyClick), for: .touchUpInside)
        applyBtn.setTitle(languageCode == "701" ? "Berikutnya" : "Next", for: .normal)
        return applyBtn
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
        tableView.register(SpecialViewCell.self, forCellReuseIdentifier: "SpecialViewCell")
        tableView.isScrollEnabled = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F5F5F5")
        view.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(210)
        }
        
        view.addSubview(appHeadView)
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        appHeadView.nameLabel.text = params["title"] ?? ""
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductDetailVc()
        }
        
        view.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 50))
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom).offset(7)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(applyBtn.snp.top).offset(-10)
        }
        
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twoImageView)
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 40))
        }
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 229, height: 166))
        }
        
        scrollView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(twoImageView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(295)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        Task {
            await self.frontInfo()
        }
        
    }
}

extension CompleteViewController {
    
    private func frontInfo() async {
        do {
            LoadingView.shared.show()
            let params = ["rival": params["productID"] ?? "",
                          "road": "1"]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/fiveyear/during/never", method: .get, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                let name = model.sagged?.vera?.acquaintances?.steering ?? ""
                let number = model.sagged?.vera?.acquaintances?.hellos ?? ""
                let date = model.sagged?.vera?.acquaintances?.mario ?? ""
                self.modelArray = [name, number, date]
                self.tableView.reloadData()
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    @objc func applyClick() {
        Task {
            await self.nextDetailInfo(with: params["productID"] ?? "")
        }
    }
    
}

extension CompleteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let names = languageCode == "701" ? ititles : etitles
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialViewCell", for: indexPath) as! SpecialViewCell
        cell.arrowImageView.isHidden = true
        if let modelArray = modelArray {
            cell.title = names[indexPath.row]
            cell.name = modelArray[indexPath.row]
        }
        return cell
    }
    
}
