//
//  PopFrontListView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/21.
//

import UIKit
import SnapKit
import BRPickerView

class PopFrontListView: BaseView {
    
    var cancelBlock: (() -> Void)?
    
    var confirmBlock: ((String, String, String) -> Void)?
    
    private let etitles: [String] = ["Name", "ID number", "Birthday"]
    
    private let ititles: [String] = ["Nama sesuai ktp", "Nomor ktp", "Ulang tahun"]
    
    var modelArray: [String]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "front_pop_s_a_image")
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
        nameLabel.text = languageCode == "701" ? "Konfirmasikan informasi" : "Confirm information"
        nameLabel.textColor = UIColor.init(hex: "#101012")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
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
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .center
        descLabel.text = languageCode == "701" ? "*Mohon periksa kembali informasi lD Anda dengan benar, jika sudah terkirim tidak akan diubah lagi" : "*Please check your lD information correctly, oncesubmitted it is not changed again"
        descLabel.textColor = UIColor.init(hex: "#FF8981")
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return descLabel
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
        tableView.register(CommonViewCell.self, forCellReuseIdentifier: "CommonViewCell")
        tableView.register(SpecialViewCell.self, forCellReuseIdentifier: "SpecialViewCell")
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
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(confirmBtn)
        bgImageView.addSubview(tableView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 533))
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
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-20)
        }
        confirmBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 305, height: 50))
            make.bottom.equalTo(descLabel.snp.top).offset(-10)
        }
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.bottom.equalTo(confirmBtn.snp.top).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopFrontListView {
    
    @objc func cancelClick() {
        self.cancelBlock?()
    }
    
    @objc func confirmClick() {
        var name: String = ""
        var number: String = ""
        var date: String = ""
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CommonViewCell {
            name = cell.nameField.text ?? ""
        }
        if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CommonViewCell {
             number = cell.nameField.text ?? ""
        }
        if let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? SpecialViewCell {
            date = cell.nameField.text ?? ""
        }
        self.confirmBlock?(name, number, date)
    }
    
}

extension PopFrontListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let names = languageCode == "701" ? ititles : etitles
        if index == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialViewCell", for: indexPath) as! SpecialViewCell
            cell.title = names[index]
            cell.name = modelArray?[index]
            cell.tapClickBlock = { [weak self] in
                guard let self = self else { return }
                self.tapTimeClick(cell: cell)
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonViewCell", for: indexPath) as! CommonViewCell
            cell.title = names[index]
            cell.name = modelArray?[index]
            return cell
        }
    }
    
}

extension PopFrontListView {
    
    private func tapTimeClick(cell: SpecialViewCell) {
        let time = cell.nameField.text ?? ""
        let datePickerView = createDatePickerView()
        datePickerView.selectDate = parseDate(from: time)
        datePickerView.pickerStyle = createPickerStyle()
        
        datePickerView.resultBlock = { [weak self] selectDate, selectValue in
            self?.handleDateSelection(selectDate, cell: cell)
        }
        
        datePickerView.show()
    }
    
    private func createDatePickerView() -> BRDatePickerView {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = languageCode == "701" ? "Pilih tanggal" : "Select date"
        return datePickerView
    }
    
    private func parseDate(from timeString: String?) -> Date {
        guard let timeString = timeString, !timeString.isEmpty else {
            return getDefaultDate()
        }
        
        let dateFormats = ["dd/MM/yyyy"]
        let dateFormatter = DateFormatter()
        
        for format in dateFormats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: timeString) {
                return date
            }
        }
        
        return getDefaultDate()
    }
    
    private func getDefaultDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: "20/11/1990") ?? Date()
    }
    
    private func createPickerStyle() -> BRPickerStyle {
        let customStyle = BRPickerStyle()
        customStyle.rowHeight = 45
        customStyle.language = "en"
        customStyle.doneBtnTitle = languageCode == "701" ? "OKE" : "OK"
        customStyle.cancelBtnTitle = languageCode == "701" ? "Batal" : "Cancel"
        customStyle.doneTextColor = UIColor(hex: "#030305")
        customStyle.selectRowTextColor = UIColor(hex: "#030305")
        customStyle.pickerTextFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        customStyle.selectRowTextFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        return customStyle
    }
    
    private func handleDateSelection(_ selectedDate: Date?, cell: SpecialViewCell) {
        guard let selectedDate = selectedDate else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let resultDateString = dateFormatter.string(from: selectedDate)
        cell.nameField.text = resultDateString
    }
    
}
