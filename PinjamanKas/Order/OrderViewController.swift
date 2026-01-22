//
//  OrderViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire
import MJRefresh

class OrderViewController: BaseViewController {
    
    var type: String = ""
    
    private var selectedButton: UIButton?
    
    var modelArray: [magicallyModel] = []
    
    lazy var orderView: OrderView = {
        let orderView = OrderView(frame: .zero)
        orderView.isHidden = true
        return orderView
    }()
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView(frame: .zero)
        emptyView.isHidden = true
        return emptyView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = languageCode == "701" ? UIImage(named: "ad_h_id_image") : UIImage(named: "ad_h_en_image")
        return oneImageView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
        oneBtn.layer.cornerRadius = 12
        oneBtn.layer.masksToBounds = true
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        oneBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        oneBtn.setTitle(languageCode == "762" ? "All" : "Semua", for: .normal)
        oneBtn.layer.borderWidth = 1
        oneBtn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
        oneBtn.tag = 0
        oneBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
        twoBtn.layer.cornerRadius = 12
        twoBtn.layer.masksToBounds = true
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        twoBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        twoBtn.setTitle(languageCode == "762" ? "Applying" : "Dalam proses", for: .normal)
        twoBtn.layer.borderWidth = 1
        twoBtn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
        twoBtn.tag = 1
        twoBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
        threeBtn.layer.cornerRadius = 12
        threeBtn.layer.masksToBounds = true
        threeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        threeBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        threeBtn.setTitle(languageCode == "762" ? "Repayment" : "Belum lunas", for: .normal)
        threeBtn.layer.borderWidth = 1
        threeBtn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
        threeBtn.tag = 2
        threeBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
        fourBtn.layer.cornerRadius = 12
        fourBtn.layer.masksToBounds = true
        fourBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        fourBtn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
        fourBtn.setTitle(languageCode == "762" ? "Finished" : "Lunas", for: .normal)
        fourBtn.layer.borderWidth = 1
        fourBtn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
        fourBtn.tag = 3
        fourBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return fourBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(appHeadView)
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        view.addSubview(oneImageView)
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appHeadView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 335, height: 127))
        }
        
        appHeadView.nameLabel.text = languageCode == "701" ? "Daftar pesanan" : "Order list"
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 335, height: 40))
        }
        
        contentView.addSubview(oneBtn)
        contentView.addSubview(twoBtn)
        contentView.addSubview(threeBtn)
        contentView.addSubview(fourBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 38))
            make.centerY.equalToSuperview()
        }
        twoBtn.snp.makeConstraints { make in
            make.left.equalTo(oneBtn.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 80, height: 38))
            make.centerY.equalToSuperview()
        }
        threeBtn.snp.makeConstraints { make in
            make.left.equalTo(twoBtn.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 80, height: 38))
            make.centerY.equalToSuperview()
        }
        fourBtn.snp.makeConstraints { make in
            make.left.equalTo(threeBtn.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 80, height: 38))
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(2)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(2)
            make.left.right.bottom.equalToSuperview()
        }
        
        emptyView.clickBlock = {
            NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
        }
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.orderListInfo(with: self.type)
            }
        })
        
        setupInitialSelectedButton()
    }
    
    private func setupInitialSelectedButton() {
        var initialButton: UIButton?
        
        switch type {
        case "4":
            initialButton = oneBtn
            
        case "7":
            initialButton = twoBtn
            
        case "6":
            initialButton = threeBtn
            
        case "5":
            initialButton = fourBtn
            
        default:
            initialButton = oneBtn
        }
        
        if let button = initialButton {
            selectButton(button)
        }
        
        Task {
            await self.orderListInfo(with: type)
        }
        
    }
    
}

extension OrderViewController {
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let tag = sender.tag
        var type: String = ""
        switch tag {
        case 0:
            type = "4"
            
        case 1:
            type = "7"
            
        case 2:
            type = "6"
            
        case 3:
            type = "5"
            
        default:
            break
        }
        
        selectButton(sender)
        
        Task {
            await self.orderListInfo(with: type)
        }
    }
    
    private func selectButton(_ button: UIButton) {
        
        let allButtons = [oneBtn, twoBtn, threeBtn, fourBtn]
        
        for btn in allButtons {
            if btn == button {
                btn.backgroundColor = UIColor.init(hex: "#030305")
                btn.setTitleColor(.white, for: .normal)
                btn.layer.borderWidth = 0
            } else {
                btn.backgroundColor = UIColor.init(hex: "#FFFFFF")?.withAlphaComponent(0.2)
                btn.setTitleColor(UIColor.init(hex: "#030305"), for: .normal)
                btn.layer.borderWidth = 1
                btn.layer.borderColor = UIColor.init(hex: "#8E8C8D")?.cgColor
            }
        }
        
        selectedButton = button
        
    }
    
}

extension OrderViewController {
    
    private func orderListInfo(with type: String) async {
        do {
            LoadingView.shared.show()
            let params = ["balance": type, "partners": "1", "profitable": "99"]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/never/instructed/great", method: .post, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                let modelArray = model.sagged?.magically ?? []
                self.modelArray = modelArray
                if modelArray.isEmpty {
                    tableView.isHidden = true
                    emptyView.isHidden = false
                }else {
                    tableView.isHidden = false
                    emptyView.isHidden = true
                }
                self.tableView.reloadData()
            }else {
                tableView.isHidden = true
                emptyView.isHidden = false
            }
            LoadingView.shared.hide()
            await self.tableView.mj_header?.endRefreshing()
        } catch {
            tableView.isHidden = true
            emptyView.isHidden = false
            LoadingView.shared.hide()
            await self.tableView.mj_header?.endRefreshing()
        }
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArray[indexPath.row]
        let pageUrl = model.alarming ?? ""
        if pageUrl.isEmpty {
            return
        }
        if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
            URLSchemeRouter.handle(pageURL: pageUrl, from: self)
        }else if pageUrl.hasPrefix("http") {
            self.pushWebVc(with: pageUrl)
        }
    }
    
}
