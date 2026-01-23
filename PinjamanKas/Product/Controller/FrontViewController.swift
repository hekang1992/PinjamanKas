//
//  FrontViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire
internal import AVFoundation
import TYAlertController

class FrontViewController: BaseViewController {
    
    var model: BaseModel?
    
    var params: [String: String] = [:]
    
    private var cameraManager: SimpleCameraManager?
    
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
        twoImageView.image = languageCode == "701" ? UIImage(named: "pro_ones_desc_image") : UIImage(named: "pro_one_desc_image")
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
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 18
        whiteView.layer.masksToBounds = true
        whiteView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return whiteView
    }()
    
    lazy var aImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "fr_bg_a_image")
        return aImageView
    }()
    
    lazy var bImageView: UIImageView = {
        let bImageView = UIImageView()
        bImageView.image = UIImage(named: "cam_e_image")
        return bImageView
    }()
    
    lazy var cImageView: UIImageView = {
        let cImageView = UIImageView()
        cImageView.image = languageCode == "701" ? UIImage(named: "foot_ain_f_image") : UIImage(named: "foot_a_f_image")
        cImageView.contentMode = .scaleAspectFit
        return cImageView
    }()
    
    lazy var dImageView: UIImageView = {
        let dImageView = UIImageView()
        dImageView.image = UIImage(named: "foot_aina_f_image")
        dImageView.isHidden = languageCode == "701" ? false : true
        return dImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .center
        descLabel.text = languageCode == "701" ? "Klik untuk mengunggah" : "Click to upload"
        descLabel.textColor = UIColor.init(hex: "#030305")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return descLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hex: "#F5F5F5")
        return lineView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.addTarget(self, action: #selector(tapClick), for: .touchUpInside)
        return clickBtn
    }()
    
    private let locationManager = LocationManager()
    
    var brute: String = ""
    
    var brawny: String = ""
    
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
            make.top.equalTo(oneImageView.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 51))
        }
        
        scrollView.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(twoImageView.snp.bottom).offset(19)
            make.size.equalTo(CGSize(width: 335, height: 395))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
        whiteView.addSubview(aImageView)
        whiteView.addSubview(descLabel)
        aImageView.addSubview(bImageView)
        whiteView.addSubview(lineView)
        whiteView.addSubview(cImageView)
        whiteView.addSubview(clickBtn)
        
        aImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 264, height: 169))
            make.top.equalToSuperview().offset(24)
        }
        
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(aImageView.snp.bottom).offset(17)
            make.height.equalTo(15)
        }
        
        bImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(58)
        }
        
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 1))
            make.top.equalTo(aImageView.snp.bottom).offset(60)
        }
        
        cImageView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 97))
        }
        
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(dImageView)
        dImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 268, height: 28))
            make.bottom.equalTo(applyBtn.snp.top).offset(-15)
        }
        
        Task {
            await self.frontInfo()
        }
        
        locationManager.fetchLocationInfo { locationInfo in }
        
        brute = String(Int(Date().timeIntervalSince1970))
        
    }
    
}

extension FrontViewController {
    
    private func frontInfo() async {
        do {
            LoadingView.shared.show()
            let params = ["rival": params["productID"] ?? "",
                          "road": "1"]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/fiveyear/during/never", method: .get, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                self.model = model
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    @objc func tapClick() {
        let cronies = self.model?.sagged?.vera?.cronies ?? 0
        if cronies == 0 {
            cameraManager = SimpleCameraManager(presentingVC: self)
            cameraManager?.takePhoto(position: .back) { [weak self] data in
                guard let self = self else { return }
                self.cameraManager = nil
                Task {
                    await self.uploadFrontImageInfo(with: data)
                }
            }
        }else {
            ToastManager.showMessage(languageCode == "701" ? "Unggahan Berhasil" : "Upload Successful")
        }
    }
    
    @objc func applyClick() {
        let cronies = self.model?.sagged?.vera?.cronies ?? 0
        if cronies == 0 {
            cameraManager = SimpleCameraManager(presentingVC: self)
            cameraManager?.takePhoto(position: .back) { [weak self] data in
                guard let self = self else { return }
                self.cameraManager = nil
                Task {
                    await self.uploadFrontImageInfo(with: data)
                }
            }
        }else {
            
        }
    }
    
    private func uploadFrontImageInfo(with data: Data) async {
        do {
            LoadingView.shared.show()
            let params = ["appear": String(Int(2 + 9)),
                          "buildings": String(Int(2 + 0)),
                          "section": "",
                          "heights": "1"]
            let model: BaseModel = try await NetworkManager.shared.uploadFile(url: "/softly/carlo/observer/might",params: params, fileData: data)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                sheetListView(with: model.sagged ?? saggedModel())
            }else {
                ToastManager.showMessage(model.strangler ?? "")
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    private func sheetListView(with model: saggedModel) {
        brawny = String(Int(Date().timeIntervalSince1970))
        let popView = PopFrontListView(frame: self.view.bounds)
        let name = model.steering ?? ""
        let number = model.hellos ?? ""
        let date = model.mario ?? ""
        popView.modelArray = [name, number, date]
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.confirmBlock = { [weak self] name, number, date in
            guard let self = self else { return }
            Task {
                let grand = await self.saveFrontInfo(with: name, number: number, date: date)
                if grand {
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    let params = ["bladder": self.params["productID"] ?? "",
                                  "hinted": "2",
                                  "shipment": self.params["orderID"] ?? "",
                                  "brute": self.brute,
                                  "brawny": self.brawny]
                    await self.softlySmallInfo(with: params)
                }
            }
        }
    }
    
    private func saveFrontInfo(with name: String, number: String, date: String) async -> Bool {
        
        let apiUrl = languageCode == "701" ? "/softly/sollozzo/leather/flickered" : "/softly/suddenly/sulked/youre"
        
        do {
            LoadingView.shared.show()
            let params = ["mario": date,
                          "hellos": number,
                          "view": UserManager.shared.getPhone(),
                          "steering": name,
                          "site": self.params["orderID"] ?? "",
                          "rival": self.params["productID"] ?? ""]
            let model: BaseModel = try await NetworkManager.shared.request(apiUrl, method: .post, params: params)
            let sinking = model.sinking ?? ""
            LoadingView.shared.hide()
            if ["0", "00"].contains(sinking) {
                self.dismiss(animated: true) {
                    let faceVc = FaceViewController()
                    faceVc.params = self.params
                    self.navigationController?.pushViewController(faceVc, animated: true)
                }
                return true
            }else {
                ToastManager.showMessage(model.strangler ?? "")
                return false
            }
        } catch {
            LoadingView.shared.hide()
            return false
        }
    }
    
}
