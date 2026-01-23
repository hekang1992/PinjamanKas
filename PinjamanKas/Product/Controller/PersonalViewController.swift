//
//  PersonalViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire
import TYAlertController
import BRPickerView

class PersonalViewController: BaseViewController {
    
    var params: [String: String] = [:]
    
    var modelArray: [furnishingModel] = []
    
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
        oneImageView.image = languageCode == "701" ? UIImage(named: "id_min_ca_image") : UIImage(named: "idn_min_ca_image")
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
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 88
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CommonViewCell.self, forCellReuseIdentifier: "CommonViewCell")
        tableView.register(SpecialViewCell.self, forCellReuseIdentifier: "SpecialViewCell")
        tableView.layer.cornerRadius = 18
        tableView.layer.masksToBounds = true
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

extension PersonalViewController {
    
    @objc func applyClick() {
        var dict = ["rival": params["productID"] ?? ""]
        for model in modelArray {
            let key = model.sinking ?? ""
            let value = model.appear ?? ""
            dict[key] = value
        }
        Task {
            await self.saveInfo(with: dict)
        }
    }
}

extension PersonalViewController {
    
    private func getPersonalInfo() async {
        do {
            LoadingView.shared.show()
            let params = ["rival": params["productID"] ?? ""]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/narrow/hollywood/thats", method: .post, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                self.modelArray = model.sagged?.furnishing ?? []
                self.tableView.reloadData()
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    private func saveInfo(with params: [String: String]) async {
        brawny = String(Date().timeIntervalSince1970)
        do {
            LoadingView.shared.show()
            let model: BaseModel = try await NetworkManager.shared.request("/softly/fight/monthsmaybe/happy", method: .post, params: params)
            LoadingView.shared.hide()
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                Task {
                    async let _ = self.nextDetailInfo(with: params["rival"] ?? "")
                    
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    let params = ["bladder": self.params["productID"] ?? "",
                                  "hinted": "4",
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
    
}

extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let mounted = model.mounted ?? ""
        if mounted == "proclaim2" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonViewCell", for: indexPath) as! CommonViewCell
            cell.model = model
            cell.textEnterBlock = { text in
                model.scrambled = text
                model.appear = text
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialViewCell", for: indexPath) as! SpecialViewCell
            cell.model = model
            cell.tapClickBlock = { [weak self] in
                guard let self = self else { return }
                self.view.endEditing(true)
                if mounted == "proclaim3" {
                    self.popSelectCityView(with: model, cell: cell)
                }else {
                    self.popSelectView(with: model, cell: cell)
                }
            }
            return cell
        }
        
    }
    
    private func popSelectView(with model: furnishingModel, cell: SpecialViewCell) {
        let popView = PopSelectListView(frame: self.view.bounds)
        popView.nameLabel.text = model.uptown ?? ""
        
        let modelArray = model.offensive ?? []
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
                model.scrambled = name
                model.appear = listModel.appear ?? ""
            }
        }
        
    }
    
    private func popSelectCityView(with model: furnishingModel, cell: SpecialViewCell) {
        
        let cityModelArray = CitysModel.shared.modelArray ?? []
        
        let listArray = CityDecodeModel.getAddressModelArray(from: cityModelArray)
        
        let stringPickerView = BRTextPickerView()
        stringPickerView.pickerMode = .componentCascade
        stringPickerView.title = model.uptown ?? ""
        stringPickerView.dataSourceArr = listArray
        
        let style = BRPickerStyle()
        style.rowHeight = 45
        style.language = "en"
        style.doneBtnTitle = languageCode == "701" ? "OKE" : "OK"
        style.cancelBtnTitle = languageCode == "701" ? "Batal" : "Cancel"
        style.doneTextColor = UIColor(hex: "#030305")
        style.selectRowTextColor = UIColor(hex: "#030305")
        style.pickerTextFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        style.selectRowTextFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        stringPickerView.pickerStyle = style
        
        stringPickerView.multiResultBlock = { models, indexs in
            if let models = models {
                let selectText = models.map { $0.text ?? "" }.joined(separator: "|")
                cell.nameField.text = selectText
                model.scrambled = selectText
                model.appear = selectText
            }
        }
        stringPickerView.show()
    }
    
}
